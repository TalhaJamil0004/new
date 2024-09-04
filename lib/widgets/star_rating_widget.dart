import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  //final GlobalKey<ScaffoldState> scaffoldKey;

  StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (index) {
        if (index < rating) {
          return IconButton(
            icon: Icon(Icons.star),
            color: Colors.yellow,
            onPressed: () {
              _showRatingMessage(context);
            },
          );
        } else {
          return IconButton(
            icon: Icon(Icons.star_border),
            color: Colors.yellow,
            onPressed: () {
              _showRatingMessage(context);
            },
          );
        }
      }),
    );
  }

  void _showRatingMessage(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Thank you for rating!'),
      duration: Duration(seconds: 2), // Adjust the duration as needed
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
