import 'package:flutter/material.dart';

class Descriptions extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var recipesData;
  Descriptions({required this.recipesData, super.key});

  @override
  State<Descriptions> createState() => _DescriptionsState();
}

class _DescriptionsState extends State<Descriptions> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 22,
            ),
            Text(
              "Description",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.secondary
                  // color: Colors.black
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.recipesData["description"],
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSecondary
                  // color: Colors.black54
                  ),
            ),
            const SizedBox(
              height: 13,
            ),
            widget.recipesData["prep_time"] == "0 min"
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Preparation Time:",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                      Text(
                        "${widget.recipesData['prep_time']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      )
                    ],
                  ),
            const SizedBox(
              height: 13,
            ),
            widget.recipesData["cook_time"] == "0 min"
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Cooking Time:",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                      Text(
                        "${widget.recipesData['cook_time']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      )
                    ],
                  ),
            const SizedBox(
              height: 13,
            ),
            widget.recipesData["additional_time"] == "0 min"
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Additional Time:",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                      Text(
                        "${widget.recipesData['additional_time']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 13,
            ),
            widget.recipesData['refrigerate_time'] == "0 min"
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Refrigeration Time:",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                      Text(
                        "${widget.recipesData['refrigerate_time']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
