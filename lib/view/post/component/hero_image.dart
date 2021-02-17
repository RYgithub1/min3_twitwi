import 'package:flutter/material.dart';




class HeroImage extends StatelessWidget {
  final Image image;
  final VoidCallback onTap;
  HeroImage({this.image, this.onTap});


  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "postImage",   /// [遷移前後の合致: 共通タグ]
      child: Material(
        color: Colors.white30,
        child: InkWell(
          onTap: onTap,
          child: image,
        ),
      ),
    );
  }
}