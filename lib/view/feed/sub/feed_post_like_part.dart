import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/style.dart';




class FeedPostLikePart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: FaIcon(FontAwesomeIcons.solidHeart),
                onPressed: null,
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.comment),
                onPressed: null,
              ),
            ],
          ),
          Text(
            "0 ${S.of(context).likes}",
            style: numberOfLikeTextStyle,
          ),
        ],
      ),
    );
  }
}