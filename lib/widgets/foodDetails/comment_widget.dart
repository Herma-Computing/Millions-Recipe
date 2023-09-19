import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool empityComment = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
            // color: Colors.white,
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.vertical(top: Radius.circular(55))),
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
                  Image.asset(
                    "assets/Ellipse 7.png",
                    width: 30,
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.68,
                      height: 43,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1, color: const Color(0xffD9D9D9))),
                      child: const Center(
                        child: TextField(
                          decoration: InputDecoration(
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
                      setState(() {
                        empityComment = !empityComment;
                      });
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
              empityComment
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
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
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/Ellipse 7.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 28),
                                        child: Text("Amanda Richarlson",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ),
                                      const Text("9 months ago",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ))
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Text(
                                        "Ok, so in stage 3/5 of this project the user inputs a string, i.e., '_XXOO_OX_' to make a move. Now in this stage 4/5 the user is supposed to enter numbered coordinates i.e., (2 3) of a table that is not shown to them. Or explained to them... Show more",
                                        style: TextStyle(
                                          // color: Color(0xff2E2E2E),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.thumb_up_alt_outlined,
                                        color: Color(0xff53E88B),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text("Reply",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                      Text("Report",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Spacer(),
                                      Icon(
                                        CupertinoIcons.delete,
                                        size: 14,
                                        color: Colors.red,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 17.0, right: 12),
                                          child: Icon(
                                            Icons.edit_outlined,
                                            size: 14,
                                          )),
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
  }
}