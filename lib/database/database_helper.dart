import 'dart:convert';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
                    CREATE TABLE IF NOT EXISTS recipes(
                        recipe_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                        name TEXT,
                        description TEXT,
                        prep_time INTEGER,
                        cook_time INTEGER,
                        refrigerate_time INTEGER,
                        additional_time INTEGER,
                        total_time INTEGER,
                        serving INTEGER,
                        recipe_yield TEXT
                      )

""");
    await database.execute("""
                    CREATE TABLE IF NOT EXISTS nutritions(
                      recipe_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                      name TEXT,
                      value TEXT,
                      FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
                    )
""");
    await database.execute("""
                    CREATE TABLE IF NOT EXISTS steps(
                      recipe_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                      step TEXT,
                      FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
                    )
""");
    await database.execute("""
                    CREATE TABLE IF NOT EXISTS ingredients(
                      recipe_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                      ingredient TEXT,
                      FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
                    )
""");

    await database.execute("""
                    CREATE TABLE IF NOT EXISTS recipe_images(
                      recipe_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                      img_url TEXT,
                      FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
                    )
""");
    await database.execute("""
                    CREATE TABLE IF NOT EXISTS catagories(
                      recipe_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                      name TEXT,
                      FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
                    )
""");

    await database.execute("""
                    CREATE TABLE IF NOT EXISTS favorite(
                      recipe_slug TEXT
                    )
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'Millions_Recipe',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createRecipes(
      String name,
      String description,
      String prepTime,
      String cookTime,
      String refrigerateTime,
      String additionalTime,
      String totalTime,
      String serving,
      String recipeYield) async {
    final db = await SqlHelper.db();

    final data = {
      'name': name,
      'description': description,
      'prep_time': prepTime,
      'cook_time': cookTime,
      'refrigerate_time': refrigerateTime,
      'additional_time': additionalTime,
      'total_time': totalTime,
      'serving': serving,
      'recipe_yield': recipeYield
    };
    final id = await db.insert('recipes', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertFavorite(String slug) async {
    final db = await SqlHelper.db();
    final data = {'recipe_slug': slug};
    final id = await db.insert('favorite', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<int> deleteFavorite(String slug) async {
    final db = await SqlHelper.db();
    final deletedRows = await db
        .delete('favorite', where: 'recipe_slug = ?', whereArgs: [slug]);
    return deletedRows;
  }

  static Future<bool> isRecipeFavorite(String slug) async {
    final db = await SqlHelper.db();
    final count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM favorite WHERE recipe_slug = ?',
      [slug],
    ));
    return count! > 0;
  }

  static Future<int> insertNutrition(
    int recipeId,
    String name,
    String value,
  ) async {
    final db = await SqlHelper.db();

    final data = {
      'recipe_id': recipeId,
      'name': name,
      'value': value,
    };

    final insertedId = await db.insert(
      'nutritions',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return insertedId;
  }

  static Future<int> insertStep(
    int recipeId,
    List<Map<String, String>> steps,
  ) async {
    final db = await SqlHelper.db();

    final stepsJson = jsonEncode(steps);

    final data = {
      'recipe_id': recipeId,
      'step': stepsJson,
    };

    final insertedId = await db.insert(
      'steps',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return insertedId;
  }

  static Future<int> insertIngredient(
    int recipeId,
    List<Map<String, String>> ingredients,
  ) async {
    final db = await SqlHelper.db();

    final ingredientsJson = jsonEncode(ingredients);

    final data = {
      'recipe_id': recipeId,
      'ingredient': ingredientsJson,
    };

    final insertedId = await db.insert(
      'ingredients',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return insertedId;
  }

  static Future<void> insertRecipeImage(int recipeId, List imageUrls) async {
    final db = await SqlHelper.db();

    final imageUrlJson = jsonEncode(imageUrls);

    final data = {
      'recipe_id': recipeId,
      'img_url': imageUrlJson,
    };

    await db.insert(
      'recipe_images',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<int> insertCategory(
    int recipeId,
    String name,
  ) async {
    final db = await SqlHelper.db();

    final data = {
      'recipe_id': recipeId,
      'name': name,
    };

    final insertedId = await db.insert(
      'categories',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return insertedId;
  }

  static Future<dynamic> getRecipeById(int id) async {
    final db = await SqlHelper.db();

    final insertedData = await db.query('recipes',
        where: 'recipe_id = ?', whereArgs: [id], limit: 1);

    if (insertedData.isNotEmpty) {
      return insertedData.first;
    } else {
      return {};
    }
  }
}