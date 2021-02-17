import 'package:flutter/material.dart';
import 'package:min3_twitwi/view/post/component/hero_image.dart';




class EnlargrImageScreen extends StatelessWidget {
  final Image image;
  EnlargrImageScreen({this.image});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: HeroImage(
          image: image,
          onTap: () => Navigator.pop(context),
        )
      ),
    );
  }
}