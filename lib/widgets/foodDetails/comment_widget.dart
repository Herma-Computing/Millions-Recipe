import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millions_recipe/api/shared_preference/shared_preference.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../providers/comment_provider.dart';

class CommentWidget extends StatefulWidget {
  final String recipeId;
  const CommentWidget({super.key, required this.recipeId});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  Future<void> fetchComment() async {
    final commentProvider = Provider.of<Comments>(context, listen: false);
    commentProvider.fetchComments(recipeId: widget.recipeId, token: token);
  }

  Future<void> fetchCommentReplay(String commentId) async {
    final commentProvider = Provider.of<Comments>(context, listen: false);
    commentProvider.fetchCommentReplays(
        recipeId: widget.recipeId, token: token, parent: commentId);
  }

  List showIndex = [];
  bool postReplay = false;
  String parentId = "0";

  final TextEditingController _postController = TextEditingController();
  bool showReplay = false;

  bool empityComment = true;
  late String token;
  late String fileUrl;
  late String userEmail;

  String commentId = "";
  bool isUpdate = false;

  @override
  void initState() {
    fileUrl = UserPreferences.getProfilePicture()!;
    token = UserPreferences.getToken()!;
    userEmail = UserPreferences.getuserProfile()[2];
    fetchComment();
    super.initState();
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<Comments>(context);
    return Consumer<Comments>(builder: (context, value, child) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
              // color: Colors.white,
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(55))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const Text("Comments",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                    const Spacer(),
                    const Text("Filter",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.slider_horizontal_3,
                          color: Colors.grey,
                          size: 18,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        // "assets/Ellipse 7.png",
                        fileUrl,
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.68,
                        height: 43,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1, color: const Color(0xffD9D9D9))),
                        child: Center(
                          child: TextField(
                            controller: _postController,
                            decoration: InputDecoration(
                              hintText: postReplay
                                  ? "Type your Replay"
                                  : "What’s on your mind",
                              contentPadding:
                                  const EdgeInsetsDirectional.only(start: 4),
                              hintStyle:
                                  const TextStyle(color: Color(0xffC1C1C1)),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        if (isUpdate) {
                          commentProvider.updateComment(
                              commentId: commentId,
                              newContent: _postController.text,
                              token: token);
                        } else if (postReplay) {
                          commentProvider.createComment(
                              recipeId: widget.recipeId,
                              content: _postController.text,
                              token: token,
                              parent: parentId);

                          fetchComment();

                          setState(() {
                            for (int i = 0;
                                i < commentProvider.comments.length + 1;
                                i++) {
                              showIndex[i] = false;
                            }
                          });
                        } else {
                          commentProvider.createComment(
                              recipeId: widget.recipeId,
                              content: _postController.text,
                              token: token);
                        }

                        _postController.clear();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 22),
                        width: 87,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Color(0xff15BE77),
                              Color(0xff53E88B),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Post",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                commentProvider.loading
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: kPrimaryColor,
                        ),
                      )
                    : commentProvider.comments.isEmpty
                        ? Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18.0),
                              child: ListView(
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(
                                        "assets/msg427565221-88978.jpg",
                                        height: 250,
                                        width: 250,
                                      ),
                                      const Text("There are no comments",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      const Text("Be the first to comment",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: ListView.builder(
                                itemCount: commentProvider.comments.length,
                                itemBuilder: (context, index) {
                                  if (showIndex.isEmpty) {
                                    for (int i = 0;
                                        i < commentProvider.comments.length + 1;
                                        i++) {
                                      showIndex.add(false);
                                    }
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.network(
                                                commentProvider
                                                    .comments[index].imageUrl,
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8),
                                              child: Text(
                                                  commentProvider
                                                      .comments[index]
                                                      .displayName,
                                                  // "Amanda Richarlson",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ),
                                            const Spacer(),
                                            Text(
                                                commentProvider.comments[index]
                                                    .commentDate,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                ))
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                                commentProvider.comments[index]
                                                    .commentContent,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                if (userEmail !=
                                                    commentProvider
                                                        .comments[index]
                                                        .authorEmail) {
                                                  commentProvider
                                                      .commentLikeDislike(
                                                          commentProvider
                                                              .comments[index]
                                                              .commentId,
                                                          token,
                                                          like: true);
                                                } else {
                                                  Flushbar(
                                                    flushbarPosition:
                                                        FlushbarPosition.BOTTOM,
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 20, 10, 5),
                                                    titleSize: 20,
                                                    messageSize: 17,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    message:
                                                        "You can not Like your Comment",
                                                    duration: const Duration(
                                                        seconds: 5),
                                                  ).show(context);
                                                }
                                              },
                                              icon: !commentProvider
                                                      .comments[index]
                                                      .isUserLiked
                                                  ? const Icon(
                                                      Icons
                                                          .thumb_up_alt_outlined,
                                                      color: Color(0xff53E88B),
                                                    )
                                                  : const Icon(
                                                      Icons.thumb_up_alt,
                                                      color: Color(0xff53E88B),
                                                    ),
                                            ),
                                            Text(commentProvider
                                                .comments[index].numOfLikes
                                                .toString()),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  if (userEmail !=
                                                      commentProvider
                                                          .comments[index]
                                                          .authorEmail) {
                                                    commentProvider
                                                        .commentLikeDislike(
                                                            commentProvider
                                                                .comments[index]
                                                                .commentId,
                                                            token,
                                                            like: false);
                                                  } else {
                                                    Flushbar(
                                                      flushbarPosition:
                                                          FlushbarPosition
                                                              .BOTTOM,
                                                      margin: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 20, 10, 5),
                                                      titleSize: 20,
                                                      messageSize: 17,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      message:
                                                          "You can not Dislike your Comment",
                                                      duration: const Duration(
                                                          seconds: 5),
                                                    ).show(context);
                                                  }
                                                },
                                                icon: !commentProvider
                                                        .comments[index]
                                                        .isUserDisliked
                                                    ? const Icon(
                                                        Icons
                                                            .thumb_down_alt_outlined,
                                                        color:
                                                            Color(0xff53E88B),
                                                      )
                                                    : const Icon(
                                                        Icons.thumb_down_alt,
                                                        color:
                                                            Color(0xff53E88B),
                                                      )),
                                            Text(commentProvider
                                                .comments[index].numOfDislike
                                                .toString()),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: TextButton(
                                                onPressed: () async {
                                                  await fetchCommentReplay(
                                                      commentProvider
                                                          .comments[index]
                                                          .commentId);

                                                  setState(() {
                                                    showIndex[index] =
                                                        !showIndex[index];
                                                    postReplay = !postReplay;
                                                    parentId = commentProvider
                                                        .comments[index]
                                                        .commentId;
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Text("Reply",
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                    Text(
                                                        commentProvider
                                                            .comments[index]
                                                            .numOfReplies
                                                            .toString(),
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Text("Report",
                                            //     style: TextStyle(
                                            //       color: Theme.of(context)
                                            //           .colorScheme
                                            //           .onPrimary,
                                            //       fontSize: 11,
                                            //       fontWeight: FontWeight.w500,
                                            //     )),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () async {
                                                if (userEmail ==
                                                    commentProvider
                                                        .comments[index]
                                                        .authorEmail) {
                                                  await commentProvider
                                                      .deleteComment(
                                                          commentId:
                                                              commentProvider
                                                                  .comments[
                                                                      index]
                                                                  .commentId,
                                                          token: token);

                                                  commentProvider.fetchComments(
                                                      recipeId: widget.recipeId,
                                                      token: token);
                                                } else {
                                                  Flushbar(
                                                    flushbarPosition:
                                                        FlushbarPosition.BOTTOM,
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 20, 10, 5),
                                                    titleSize: 20,
                                                    messageSize: 17,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    message: "Forbiden Action",
                                                    duration: const Duration(
                                                        seconds: 5),
                                                  ).show(context);
                                                }
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.delete,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 17.0, right: 10),
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (userEmail ==
                                                        commentProvider
                                                            .comments[index]
                                                            .authorEmail) {
                                                      _postController.text =
                                                          commentProvider
                                                              .comments[index]
                                                              .commentContent;

                                                      setState(() {
                                                        isUpdate = true;
                                                        commentId =
                                                            commentProvider
                                                                .comments[index]
                                                                .commentId;
                                                      });
                                                    } else {
                                                      Flushbar(
                                                        flushbarPosition:
                                                            FlushbarPosition
                                                                .BOTTOM,
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            10, 20, 10, 5),
                                                        titleSize: 20,
                                                        messageSize: 17,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        message:
                                                            "Forbiden Action",
                                                        duration:
                                                            const Duration(
                                                                seconds: 5),
                                                      ).show(context);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit_outlined,
                                                    size: 16,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        Visibility(
                                            visible: showIndex[index],
                                            child:
                                                commentProvider.commentReplays
                                                        .isNotEmpty
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 45.0,
                                                                bottom: 12,
                                                                top: 15),
                                                        child: Expanded(
                                                          child: SizedBox(
                                                            height: 100.0 *
                                                                commentProvider
                                                                    .commentReplays
                                                                    .length,
                                                            // width: 60,
                                                            child: Row(
                                                              children: [
                                                                const VerticalDivider(
                                                                  color: Colors
                                                                      .grey,
                                                                  thickness: 1,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child: ListView.builder(
                                                                      shrinkWrap: true,
                                                                      // physics:
                                                                      //     const NeverScrollableScrollPhysics(),
                                                                      itemCount: commentProvider.commentReplays.length,
                                                                      itemBuilder: (context, index) {
                                                                        return Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(30),
                                                                                  child: Image.network(
                                                                                    commentProvider.commentReplays[index].imageUrl,
                                                                                    width: 30,
                                                                                    height: 30,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                                                                                  child: Text(commentProvider.commentReplays[index].displayName,
                                                                                      // "Amanda Richarlson",
                                                                                      style: const TextStyle(
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.w400,
                                                                                      )),
                                                                                ),
                                                                                const Spacer(),
                                                                                Text(commentProvider.commentReplays[index].commentDate,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 10,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ))
                                                                              ],
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                                                child: Text(commentProvider.commentReplays[index].commentContent,
                                                                                    textAlign: TextAlign.start,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 12,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    )),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                IconButton(
                                                                                  onPressed: () {
                                                                                    if (userEmail != commentProvider.commentReplays[index].authorEmail) {
                                                                                      commentProvider.commentLikeDislike(commentProvider.commentReplays[index].commentId, token, like: true);
                                                                                    } else {
                                                                                      Flushbar(
                                                                                        flushbarPosition: FlushbarPosition.BOTTOM,
                                                                                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                                                                                        titleSize: 20,
                                                                                        messageSize: 17,
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                        message: "Forbiden Action",
                                                                                        duration: const Duration(seconds: 5),
                                                                                      ).show(context);
                                                                                    }
                                                                                  },
                                                                                  icon: !commentProvider.commentReplays[index].isUserLiked
                                                                                      ? const Icon(
                                                                                          size: 16,
                                                                                          Icons.thumb_up_alt_outlined,
                                                                                          color: Color(0xff53E88B),
                                                                                        )
                                                                                      : const Icon(
                                                                                          size: 16,
                                                                                          Icons.thumb_up_alt,
                                                                                          color: Color(0xff53E88B),
                                                                                        ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 8,
                                                                                ),
                                                                                IconButton(
                                                                                    onPressed: () {
                                                                                      if (userEmail != commentProvider.commentReplays[index].authorEmail) {
                                                                                        commentProvider.commentLikeDislike(commentProvider.commentReplays[index].commentId, token, like: false);
                                                                                      } else {
                                                                                        Flushbar(
                                                                                          flushbarPosition: FlushbarPosition.BOTTOM,
                                                                                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                                                                                          titleSize: 20,
                                                                                          messageSize: 17,
                                                                                          borderRadius: BorderRadius.circular(8),
                                                                                          message: "Forbiden Action",
                                                                                          duration: const Duration(seconds: 5),
                                                                                        ).show(context);
                                                                                      }
                                                                                    },
                                                                                    icon: !commentProvider.commentReplays[index].isUserDisliked
                                                                                        ? const Icon(
                                                                                            size: 16,
                                                                                            Icons.thumb_down_alt_outlined,
                                                                                            color: Color(0xff53E88B),
                                                                                          )
                                                                                        : const Icon(
                                                                                            size: 16,
                                                                                            Icons.thumb_down_alt,
                                                                                            color: Color(0xff53E88B),
                                                                                          )),
                                                                                const Spacer(),
                                                                                IconButton(
                                                                                  onPressed: () async {
                                                                                    if (userEmail == commentProvider.commentReplays[index].authorEmail) {
                                                                                      await commentProvider.deleteComment(commentId: commentProvider.commentReplays[index].commentId, token: token);

                                                                                      commentProvider.fetchComments(recipeId: widget.recipeId, token: token);
                                                                                    } else {
                                                                                      Flushbar(
                                                                                        flushbarPosition: FlushbarPosition.BOTTOM,
                                                                                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                                                                                        titleSize: 20,
                                                                                        messageSize: 17,
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                        message: "Forbiden Action",
                                                                                        duration: const Duration(seconds: 5),
                                                                                      ).show(context);
                                                                                    }
                                                                                  },
                                                                                  icon: const Icon(
                                                                                    CupertinoIcons.delete,
                                                                                    size: 16,
                                                                                    color: Colors.red,
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                    padding: const EdgeInsets.only(left: 17.0, right: 10),
                                                                                    child: IconButton(
                                                                                      onPressed: () {
                                                                                        if (userEmail == commentProvider.commentReplays[index].authorEmail) {
                                                                                          _postController.text = commentProvider.commentReplays[index].commentContent;

                                                                                          setState(() {
                                                                                            isUpdate = true;
                                                                                            commentId = commentProvider.commentReplays[index].commentId;
                                                                                          });
                                                                                        } else {
                                                                                          Flushbar(
                                                                                            flushbarPosition: FlushbarPosition.BOTTOM,
                                                                                            margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                                                                                            titleSize: 20,
                                                                                            messageSize: 17,
                                                                                            borderRadius: BorderRadius.circular(8),
                                                                                            message: "Forbiden Action",
                                                                                            duration: const Duration(seconds: 5),
                                                                                          ).show(context);
                                                                                        }
                                                                                      },
                                                                                      icon: const Icon(
                                                                                        Icons.edit_outlined,
                                                                                        size: 16,
                                                                                      ),
                                                                                    )),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        );
                                                                      }),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container())
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
              ],
            ),
          ));
    });
  }
}
