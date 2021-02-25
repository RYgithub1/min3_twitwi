import 'package:flutter/material.dart';
import 'package:min3_twitwi/enum/constant.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/login/login_screen.dart';
import 'package:min3_twitwi/viewmodel/profile_view_model.dart';
import 'package:min3_twitwi/viewmodel/theme_change_view_model.dart';
import 'package:provider/provider.dart';




class ProfileSettingPart extends StatelessWidget {
  final ProfileMode profileMode;
  ProfileSettingPart({this.profileMode});


  @override
  Widget build(BuildContext context) {
    /// [theme動的変更: V変更ある: listen: true]
    final themeChangeViewModel = Provider.of<ThemeChangeViewModel>(context);
    final dark = themeChangeViewModel.isDarkMode;


    return PopupMenuButton(
      icon: Icon(Icons.settings),
      // onSelected: (value) => _onPopupMenuSelected(context, value),
      onSelected: (value) => _onPopupMenuSelected(context, value, dark),   /// [<bool>DARKMODEパス]
      itemBuilder: (context) {
        if (profileMode == ProfileMode.MYSELF) {
          return [
            PopupMenuItem(
              value: ProfileSettingMenu.THEME_CHANGE,
              child: dark /// [bool]
                  ? Text(S.of(context).changeToLightTheme)
                  : Text(S.of(context).changeToDarkTheme),
            ),
            PopupMenuItem(
              value: ProfileSettingMenu.SIGN_OUT,
              child: Text(S.of(context).signOut),
            ),
          ];
        } else {
          return [
            PopupMenuItem(
              value: ProfileSettingMenu.THEME_CHANGE,
              child: Text(S.of(context).changeToLightTheme),
            ),
            // else: (mode == ProfileMode.OTHER): サインアウト不可
          ];
        }
      },
    );
  }


  _onPopupMenuSelected(BuildContext context, ProfileSettingMenu selectedMenu, bool dark) {
    switch(selectedMenu) {
      case ProfileSettingMenu.THEME_CHANGE:   /// [theme動的変更]
        final themeChangeViewModel = Provider.of<ThemeChangeViewModel>(context, listen: false);
        themeChangeViewModel.setTheme(!dark);   /// [!xxx: Theme変更<bool>2通り、反例!]
        break;
      case ProfileSettingMenu.SIGN_OUT:
        _signOut(context);
        break;
    }
  }
  void _signOut(BuildContext context) async {
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    await profileViewModel.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => LoginScreen()
    ));
  }



}