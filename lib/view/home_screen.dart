import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'feed/page/feed_page.dart';
import 'search/page/search_page.dart';
import 'post/page/post_page.dart';
import 'activity/page/activity_page.dart';
import 'profile/page/profile_page.dart';




class HomeScreen extends StatefulWidget {
  // HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}




class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    _pages = [
      FeedPage(),
      SearchPage(),
      PostPage(),
      ActivityPage(),
      ProfilePage(
        profileMode: ProfileMode.MYSELF,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.search),
            label: S.of(context).search,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.plusSquare),
            label: S.of(context).add,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart),
            label: S.of(context).activities,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: S.of(context).user,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.orange[300],
      ),
    );
  }
}