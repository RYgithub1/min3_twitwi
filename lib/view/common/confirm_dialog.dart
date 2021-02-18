import 'package:flutter/material.dart';
import 'package:min3_twitwi/generated/l10n.dart';



/// [共通ダイアログ: TopLevelFunc: xxx -> showConfirmDialog]
showConfirmDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
  @required ValueChanged onConfirmed
}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ConfirmDialog(    /// [showDialog -> ConfirmDialog]
          title: title,
          content: content,
          onConfirmed: onConfirmed,
      ),
    );
}




/// [showDialog -> ConfirmDialog]
class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final ValueChanged<bool> onConfirmed;   /// [yes/no: Need argu<bool>]
  ConfirmDialog({this.title, this.content, this.onConfirmed});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirmed(true);
            },
            child: Text(S.of(context).yes),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirmed(false);
            },
            child: Text(S.of(context).no),
          ),
        ],
      ),
    );
  }
}