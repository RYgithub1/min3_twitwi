import 'package:flutter/material.dart';
import 'package:min3_twitwi/data/user.dart';
import 'package:min3_twitwi/view/common/user_card.dart';
import 'package:min3_twitwi/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';




/// [SearchDelegate<検索したい結果のTA>]
class SearchUserDelegate extends SearchDelegate<User> {

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      brightness: Brightness.dark,
    );
  }


  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        print("comm230: buildLeading: no result");
        close(context, null);   /// [SearchDelegate画面のclose: 返す結果: null]
      }
    );
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [   /// [返り値はList<Widget>ゆえ]
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          print("comm231: buildActions: ");
          /// [SearchDelegate: queryに(検索内容)格納される]
          query = "";
        }
      ),
    ];
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchDelegate(context);
  }
  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchDelegate(context);
  }
  /// [==== 検索 ====]
  Widget _buildSearchDelegate(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
    /// [query: SearchDelegateの検索結果格納]
    searchViewModel.searchUser(query);

    return ListView.builder(
      itemCount: searchViewModel.soughtUsers.length,
      itemBuilder: (context, int index) {
        final user = searchViewModel.soughtUsers[index];
        return UserCard(
          onTap: () {
            close(context, user);   /// [SearchDelegate画面のclose: 返す結果: user]
          },
          photoUrl: user.photoUrl,
          title: user.inAppUserName,
          subtitle: user.bio,
        );
      }
    );
  }



}