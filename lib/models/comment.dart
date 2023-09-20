// ignore_for_file: public_member_api_docs, sort_constructors_first

//-----Comment model-----------------//
import 'package:flutter/material.dart';

class Comment with ChangeNotifier {
  final String commentId;
  final String commentAuthor;
  final String postID;
  final String authorEmail;
  final String commentContent;
  final String commentDate;
  final String authorId;
  // final String authorName;
  final String imageUrl; //author_avatar_urls
  final String displayName;
  final String commentParent;
  final int numOfReplies;
  final int numOfLikes;

  final int numOfDislike;
  // final String content;
  // final bool isUserLiked;
  // List<Comment>? replies;

  Comment(
      {
      // required this.content,
      // required this.isUserLiked,
      required this.commentId,
      required this.commentAuthor,
      required this.postID,
      required this.authorEmail,
      required this.commentContent,
      required this.commentDate,
      required this.authorId,

      // required this.authorName,

      required this.imageUrl,
      required this.displayName,
      required this.commentParent,
      required this.numOfReplies,
      required this.numOfLikes,
      required this.numOfDislike});

  Comment.fromJson(Map<String, dynamic> json)
      :

        // content =
        //     json['total_time'] == null ? "0" : json['total_time'] as String,
        // isUserLiked =
        //     json['prep_time'],
        commentId = json['comment_ID'],
        commentAuthor = json['comment_author'],
        postID = json['comment_post_ID'],
        authorEmail = json['comment_author_email'],
        imageUrl = json['author_avatar_urls'],
        displayName = json['display_name'],
        commentParent = json['comment_parent'],
        numOfReplies = json['child_comments_count'],
        numOfLikes = json['likes'],
        numOfDislike = json['dislikes'],
        commentContent = json['comment_content'],
        commentDate = json['comment_date'],
        authorId = json['user_id'];
  // authorName = json['steps'];

  Map<String, dynamic> toJson() => {
        'comment_ID': commentId,
        'comment_post_ID': postID,
        'comment_author': commentAuthor,
        'comment_author_email': authorEmail,
        'comment_date': commentDate,
        'user_id': authorId,
        'comment_parent': commentParent,
        'comment_content': commentContent,
        'display_name': displayName,
        'author_avatar_urls': imageUrl,
        'child_comments_count': numOfReplies,
        'likes': numOfLikes,
        'dislikes': numOfDislike,
      };
}
