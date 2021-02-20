import 'package:flutter/material.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/view/feed/component/feed_post_tile.dart';
import 'package:min3_twitwi/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';




class FeedSubPage extends StatelessWidget {
  final FeedMode feedMode;
  FeedSubPage({@required this.feedMode});


  @override
  Widget build(BuildContext context) {

    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    feedViewModel.setFeedUser(feedMode, null);   /// [enum: どっちから開くか && user属性は]
    Future(  () => feedViewModel.getPosts(feedMode)  );   /// [Futureで逃がす]

    return Consumer<FeedViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isProcessing) {
          return CircularProgressIndicator();
        } else {
          return RefreshIndicator(
            onRefresh: () => feedViewModel.getPosts(feedMode),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: viewModel.posts.length,
              itemBuilder: (context, index) {
                return FeedPostTile(
                  feedMode: feedMode,
                  post: viewModel.posts[index],
                );
              },
            ),
          );
        }
      },
    );
  }
}