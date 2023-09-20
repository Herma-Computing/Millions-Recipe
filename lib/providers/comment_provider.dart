import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api_service/constants.dart';
import '../models/comment.dart';

class Comments with ChangeNotifier {
  bool _loading = false;

  List<Comment> comments = [];

  List<Comment> recipes = [];
  // List<Comment> favoriteRecipes = [];

  bool get loading => _loading;

  Future fetchComments(
      {required String recipeId,
      int page = 1,
      int perPage = 10,
      String parent = '0',
      required String token}) async {
    _loading = true;

    comments.clear();
    var dio = Dio();

    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      '${AppUrl.commentsFetch}/$recipeId/$parent?page=$page&per_page=$perPage',
      queryParameters: {'page': '$page', 'per_page': '$perPage'},
    );

    if (response.statusCode == 200) {
      Comment comment;
      response.data.forEach((el) async => {
            comment = Comment.fromJson(el),
            comments.add(comment),
          });
    } else {
      throw Exception('Failed to fetch comments from the server.');
    }

    _loading = false;
    notifyListeners();
  }

  Future createComment(
      {required String recipeId,
      required String content,
      required String token,
      String parent = '0'}) async {
    _loading = true;
    var dio = Dio();

    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.post(
      '${AppUrl.commentCreate}/$recipeId/$parent',
      queryParameters: {
        'comment_content': content,
      },
    );

    if (response.statusCode == 200) {
      final commentMap = response.data['comment'] as Map<String, dynamic>;
      final newComment = Comment.fromJson(commentMap);

      comments.add(newComment);
    } else {
      throw Exception('Failed to create the comment on the server.');
    }
    _loading = false;
    notifyListeners();
  }

  Future<bool?> updateComment(
      {required String commentId,
      required String newContent,
      required String token}) async {
    var dio = Dio();
//TODO not updating problem
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.patch(
      '${AppUrl.commentUpdate}/$commentId/?comment_content=$newContent',
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update the comment on the server.');
    }
  }

  Future<bool?> commentLikeDislike(String commentId, String token,
      {bool like = true}) async {
    /// if the named parameter 'like' is set to false, it's considered as dislike.
    // this method returns true if the comment is liked/disliked successfully
    var dio = Dio();
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.post(
      "${AppUrl.commentLikeDislike}/$commentId/?like_or_dislike=${like ? 'L' : 'D'}",
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to like/dislike the comment on the server.');
    }
  }

  Future<bool?> deleteComment(
      {required String commentId, required String token}) async {
    // this method returns true if the comment is deleted successfully
    var dio = Dio();
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.delete(
      '${AppUrl.commentDelete}/$commentId',
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete the comment from the server.');
    }
  }
}
