import 'package:flutter/material.dart';

class BottomPicker extends StatelessWidget {
  final VoidCallback onClicked;
  final Icon icon;
  final displayText;

  const BottomPicker(
      {Key? key,
      required this.onClicked,
      required this.displayText,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '$displayText',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(width: 150),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: icon,
            )
          ],
        ),
        onPressed: onClicked,
      );
}
