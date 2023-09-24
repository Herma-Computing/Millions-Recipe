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

  final TextEditingController _postController = TextEditingController();

  bool empityComment = true;
  late String token;
  late String fileUrl;
  String commentId = "";
  bool isUpdate = false;
  @override
  void initState() {
    fileUrl = UserPreferences.getProfilePicture()!;
    token = UserPreferences.getToken()!;
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
                            decoration: const InputDecoration(
                              hintText: "What’s on your mind",
                              contentPadding:
                                  EdgeInsetsDirectional.only(start: 4),
                              hintStyle: TextStyle(color: Color(0xffC1C1C1)),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                commentProvider
                                                    .commentLikeDislike(
                                                        widget.recipeId, token,
                                                        like: true);
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
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  commentProvider
                                                      .commentLikeDislike(
                                                          widget.recipeId,
                                                          token,
                                                          like: false);
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
                                            Text("Reply",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Text("Report",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () async {
                                                await commentProvider
                                                    .deleteComment(
                                                        commentId:
                                                            commentProvider
                                                                .comments[index]
                                                                .commentId,
                                                        token: token);

                                                commentProvider.fetchComments(
                                                    recipeId: widget.recipeId,
                                                    token: token);
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.delete,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                _postController.text =
                                                    commentProvider
                                                        .comments[index]
                                                        .commentContent;

                                                setState(() {
                                                  isUpdate = true;
                                                  commentId = commentProvider
                                                      .comments[index]
                                                      .commentId;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.edit_outlined,
                                                size: 16,
                                              ),
                                            ),
                                          ],
                                        )
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
