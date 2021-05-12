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
        height: 44,
        width: 43,
        child: Image.network(
          src,
          cacheHeight: 200,
          fit: BoxFit.scaleDown,
          errorBuilder: (context, error, stackTrace) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(child: Image.asset('assets/ingredient_stub.png')),
            );
          },
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded ?? false) {
              return child;
            }
            return AnimatedOpacity(
              child: child,
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          },

          // frameBuilder: (context, child, frame, wasSynchronouslyLoaded)
          // => wasSynchronouslyLoaded ? child : Center(child: Padding(
          //   padding: const EdgeInsets.all(4.0),
          //   child: Image.asset('assets/ingredient_stub.png'),
          // )),
        ),
      ),
    );
  }
}
