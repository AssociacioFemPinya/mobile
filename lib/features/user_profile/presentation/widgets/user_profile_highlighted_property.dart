import 'package:flutter/material.dart';

class userProfileHighlightedPropertyWidget extends StatelessWidget {
  final String value;

  const userProfileHighlightedPropertyWidget({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person, color: Colors.blue, size: 36),
      title: Text(
        value,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }
}
