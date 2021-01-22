import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const TitleWidget({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Icon(icon, size: 100),
          const SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      );
}
