import 'package:flutter/material.dart';

class Barriel extends StatelessWidget {
  const Barriel({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: size,
      child: Column(
        children: [
          Container(
            height: size - size / 10,
            decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(width: 10, color: Colors.green.shade900)),
          ),
        ],
      ),
    );
  }
}
