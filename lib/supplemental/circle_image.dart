import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  CircleImage({@required this.src});

  final String src;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 30,
      child: SizedBox(
        height: 45,
        width: 45,
        child: Image.network(
          src,
          fit: BoxFit.scaleDown,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}