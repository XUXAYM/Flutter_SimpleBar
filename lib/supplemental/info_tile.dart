import 'package:flutter/material.dart';

import '../constants.dart';

class InfoListTile extends StatelessWidget {
  InfoListTile({
    @required this.title,
    this.value,
  });

  final String title;
  final Object value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: kTitleGreyColor,
          ),
        ),
        Text(
          value != null ? value.toString() : 'No information',
          style:
          TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF3D3D3D)),
        ),
      ],
    );
  }
}