import 'package:flutter/material.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/style.dart';
import 'package:min3_twitwi/view/profile/screen/profile_screen.dart';
import 'package:min3_twitwi/view/search/component/search_user_delegate.dart';



class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: InkWell(
          splashColor: Colors.purple[200],
          onTap: () => _searchUser(context),
          child: Text(
            S.of(context).search,
            style: searchPageAppbatTitleTextStyle
          ),
        ),
        // actions: <Widget>[],
      ),
      body: Center(
        child: Text("SearchPage"),
      ),
    );
  }



  void _searchUser(BuildContext context) async {
    /// [SearchDelegate使う: Future<T> showSearch<T>()に投げる]
    /// [extends SearchDelegate<User>  -->> 投げたらUserで返ってくる]
    final selectedUser = await showSearch(
      context: context,   /// [showSearchにcontext渡す]
      delegate: SearchUserDelegate(),   /// [Navigator遷移でなくDelegateに投げる]
    );

    /// [検索結果を受けた（今回User）を受け -> profileへ]
    if ( selectedUser != null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => ProfileScreen(
          profileMode: ProfileMode.OTHER,
          selectedUser: selectedUser,
        ),
      ));
    }
  }



}