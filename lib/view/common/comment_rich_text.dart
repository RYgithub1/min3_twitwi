import 'package:flutter/material.dart';
import 'package:min3_twitwi/view/common/style.dart';




class CommentRichText extends StatefulWidget {
  final String name;
  final String text;
  CommentRichText({@required this.name, @required this.text});

  @override
  _CommentRichTextState createState() => _CommentRichTextState();
}




class _CommentRichTextState extends State<CommentRichText> {
  int _maxLines = 2;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(   /// [GestureDetector: タップ開閉]
      onTap: () {
        setState(() {
          _maxLines = 100;
        });
      },

      child: RichText(
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          // text: 'Hello ',
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(text: widget.name, style: commentNameTextStyle),
            TextSpan(text: ' : '),
            TextSpan(text: widget.text, style: commentContentTextStyle),
          ],
        ),
      ),
    );
  }
}