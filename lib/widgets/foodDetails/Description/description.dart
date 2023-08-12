import 'package:flutter/material.dart';

import '../../../models/recipe_model.dart';

class Descriptions extends StatefulWidget {
  final Recipe meal;
  const Descriptions({required this.meal, super.key});

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
            const Text(
              "Description",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.meal.description,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54),
            ),
            const SizedBox(
              height: 13,
            ),
            widget.meal.prep_time == ""
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
                        widget.meal.prep_time,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      )
                    ],
                  ),
            const SizedBox(
              height: 13,
            ),
            widget.meal.cook_time == ""
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
                        widget.meal.cook_time,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      )
                    ],
                  ),
            const SizedBox(
              height: 13,
            ),
            widget.meal.additional_time == ""
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
                        widget.meal.additional_time,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 13,
            ),
            widget.meal.refrigerate_time == ""
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
                        widget.meal.refrigerate_time,
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
