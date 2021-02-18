import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class ButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final String label;
  ButtonWithIcon({this.onPressed, this.iconData, this.label});


  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: onPressed,
      icon: FaIcon(iconData),
      label: Text(label),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}