import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard_demo/card_see_all.dart';

class ReviewsCard extends StatefulWidget {
  const ReviewsCard({super.key});

  @override
  State<ReviewsCard> createState() => _ReviewsCardState();
}

const _reviewTexts = [
  [
    "Very bad!",
    "Bad!",
    "Not bad!",
    "Good!",
    "Very good!",
  ],
  [
    "It's a disaster!",
    "It's bad!",
    "It's ok!",
    "It's good!",
    "It's great!",
  ],
  [
    "It can't be worse!",
    "Really bad!",
    "It's acceptable!",
    "It's good!",
    "It's perfect!",
  ]
];

const initials = [
  "PA",
  "AR",
  "MA",
  "AL",
  "AN",
  "TH",
  "JC",
  "JH",
  "LP",
  "MR",
  "TL",
  "MP",
];

class _ReviewsCardState extends State<ReviewsCard> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final rand = Random(15);
    return CardSeeAll(
      child: Scrollbar(
        thumbVisibility: true,
        controller: controller,
        child: ListView.builder(
          itemCount: 100,
          padding: EdgeInsets.symmetric(vertical: 6),
          controller: controller,
          itemBuilder: (context, index) {
            final stars = rand.nextInt(5) + 1;

            return ListItem(
              stars: stars,
              text: _reviewTexts[rand.nextInt(3)][stars - 1],
              initials: initials[rand.nextInt(initials.length)],
            );
          },
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.stars,
    required this.text,
    required this.initials,
  });

  final int stars;
  final String text;
  final String initials;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(initials),
      ),
      onTap: () {
        showReview(context, stars: stars, text: text, initials: initials);
      },
      title: Row(
        children: [
          for (var i = 0; i < stars; i++)
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
          for (var i = 0; i < 5 - stars; i++)
            Icon(
              Icons.star,
              color: Colors.grey,
            ),
        ],
      ),
      subtitle: Text(text),
    );
  }
}

showReview(
  BuildContext context, {
  required String text,
  required int stars,
  required String initials,
}) {
  // Show a dialog with details about the review
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          for (var i = 0; i < stars; i++)
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
          for (var i = 0; i < 5 - stars; i++)
            Icon(
              Icons.star,
              color: Colors.grey,
            ),
        ],
      ),
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Close"),
        ),
      ],
    ),
  );
}
