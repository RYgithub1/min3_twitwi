import 'package:flutter/material.dart';
import 'package:min3_twitwi/generated/l10n.dart';
import 'package:min3_twitwi/view/common/circle_photo.dart';
import 'package:min3_twitwi/view/common/confirm_dialog.dart';
import 'package:min3_twitwi/view/common/style.dart';
import 'package:min3_twitwi/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




class EditProfileScreen extends StatefulWidget {
  // EditProfileScreen({Key key}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}




class _EditProfileScreenState extends State<EditProfileScreen> {
  String _photoUrl = "";
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _bioTextEditingController = TextEditingController();
  bool _isImageFromFile = false; /// [どっからのデータか、場合分け]

  @override
  void initState() {
    super.initState();
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final profileUser = profileViewModel.profileUser;
    _photoUrl = profileUser.photoUrl;
    _isImageFromFile = false;

    _nameTextEditingController.text = profileUser.inAppUserName;
    _bioTextEditingController.text = profileUser.bio;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(S.of(context).editProfile),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () => showConfirmDialog(
              context: context,
              title: S.of(context).editProfile,
              content: S.of(context).editProfileConfirm,
              onConfirmed: (isConfirmed) {
                if (isConfirmed) {
                  _updateProfile(context);
                }
              },
            ),
          ),
        ],
      ),
      body: Consumer<ProfileViewModel>(
        builder: (_, viewModel, child) {   /// [contextいらんので_]
          return viewModel.isProcessing
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 12.0),
                        Center(
                          child: CirclePhoto(
                            isImageFromFile: _isImageFromFile,
                            photoUrl: _photoUrl,
                            radius: 60.0,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Center(
                          child: InkWell(
                            /// [photo変更]
                            onTap: () => _pickNewProfileImage(),
                            child: Text(
                              S.of(context).changeProfilePhoto,
                              style: changeProfilePhotoTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text("NAME", style: editProfileTitleTextStyle),
                        TextField(controller: _nameTextEditingController),
                        Text("BIO", style: editProfileTitleTextStyle),
                        TextField(controller: _bioTextEditingController),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }



  Future<void> _pickNewProfileImage() async {
    _isImageFromFile = false;   /// [場合分け: 最初はfalse]
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    _photoUrl = await profileViewModel.pickProfileImage();
    setState(() {    /// [image取得後にsetでtrue]
      _isImageFromFile = true;
    });
  }



  void _updateProfile(BuildContext context) async {
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    await profileViewModel.updateProfile(
      _photoUrl,
      _isImageFromFile,
      _nameTextEditingController.text,
      _bioTextEditingController.text,
    );
    Navigator.pop(context);
  }



}

