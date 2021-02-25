import 'package:flutter/material.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/view/profile/component/subcomponent/profile_bio.dart';
import 'package:min3_twitwi/view/profile/component/subcomponent/profile_image.dart';
import 'package:min3_twitwi/view/profile/component/subcomponent/profile_record.dart';




class ProfileDetailPart extends StatelessWidget {
  final ProfileMode profileMode;
  ProfileDetailPart({@required this.profileMode});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ProfileImage(),
              ),
              Expanded(
                flex: 3,
                child: ProfileRecord(),
              ),
            ],
          ),
          SizedBox(height: 12),
          ProfileBio(
            mode: profileMode,
          ),
        ],
      ),
    );
  }
}