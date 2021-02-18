import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_twitwi/data/location.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/style.dart';
import 'package:min3_twitwi/view/post/screen/map_screen.dart';
import 'package:min3_twitwi/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';




class PostLocationPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    return ListTile(
      title: Text(
        postViewModel.locationString,
        style: postLocationTextStyle,
      ),

      subtitle: _latLngPart(postViewModel.location, context),

      trailing: IconButton(
        icon: FaIcon(FontAwesomeIcons.mapMarkerAlt),
        onPressed: () => _openMapScreen(context, postViewModel.location),    /// [map開く]
      ),
    );
  }



  _latLngPart(Location location, BuildContext context) {
    const spaceWidth = 8.0;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Chip(label: Text(S.of(context).latitude)),
        SizedBox(width: spaceWidth),

        Text(location.latitude.toStringAsFixed(2)),   /// [toStringAsFixed(2): 小数第二位]
        SizedBox(width: spaceWidth),

        Chip(label: Text(S.of(context).latitude)),
        SizedBox(width: spaceWidth),

        Text(location.longitude.toStringAsFixed(2)),   /// [toStringAsFixed(2): 小数第二位]
      ],
    );
  }



  _openMapScreen(BuildContext context, Location location) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => MapScreen(
        location: location,
      ),
    ));
  }



}