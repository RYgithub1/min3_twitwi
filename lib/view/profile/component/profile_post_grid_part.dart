import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/post.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/view/feed/screen/feed_screen.dart';
import 'package:min3_twitwi/view/feed/sub/feed_post_image_from_url_part.dart';
import 'package:min3_twitwi/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




class ProfilePostGridPart extends StatelessWidget {
  final List<Post> posts;
  ProfilePostGridPart({@required this.posts});


  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 4,
      children: posts.isEmpty
          ? <Widget>[Container()]
          : List.generate(
            posts.length,
            (int index) {
              return InkWell(
                splashColor: Colors.orange[200],
                child: FeedPostImageFromUrlPart(
                  imageUrl: posts[index].imageUrl,
                ),
                onTap: () => _openFeedScreen(context, index),

              );
            },
          ),
    );
  }


  _openFeedScreen(BuildContext context, int index) {
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final feedUser = profileViewModel.profileUser;

    Navigator.push(context, MaterialPageRoute(
      builder: (_) => FeedScreen(
        feedUser: feedUser,
        feedMode: FeedMode.FROM_PROFILE,
        index: index,
      ),
    ));
  }



}