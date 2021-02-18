import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/button_with_icon.dart';
import 'package:min3_twitwi/view/common/style.dart';
import 'package:min3_twitwi/view/home_screen.dart';
import 'package:min3_twitwi/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';




class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.isLoading
                ? CircularProgressIndicator()
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      S.of(context).appTitle,
                      style: loginTitleTextStyle,
                    ),
                    SizedBox(height: 20),
                    ButtonWithIcon(
                      onPressed: () => login(context),
                      iconData: FontAwesomeIcons.sign,
                      label: S.of(context).signIn,
                    ),
                  ],
                );
          },
        ),
      ),
    );
  }



  login(BuildContext context) async {
    final loginViewModel =Provider.of<LoginViewModel>(context, listen: false);
    await loginViewModel.signIn();

    if (!loginViewModel.isSuccessful) {
      Toast.show(S.of(context).signInFailed, context);
      return;
    }
    _openHomeScreen(context);
  }
  void _openHomeScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => HomeScreen(),
    ));
  }


}