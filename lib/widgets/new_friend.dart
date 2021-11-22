import 'package:cinemates/alerts/alert_dialog_model.dart';
import 'package:cinemates/database_model/check.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:cinemates/database_model/friendship.dart';

class NewFriend extends StatefulWidget {
  const NewFriend({Key key}) : super(key: key);

  @override
  _NewFriendState createState() => _NewFriendState();
}

class _NewFriendState extends State<NewFriend> {
  final textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: textFieldController,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
                cursorColor: Style.Colors.secondColor,
                cursorWidth: 1.5,
                decoration: InputDecoration(
                  hintText: "Invia richiesta amicizia a ...",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                      fontSize: 18.0),
                  prefixIcon: Icon(EvaIcons.searchOutline, color: Colors.grey),
                  suffixIcon: IconButton(
                      icon: Icon(EvaIcons.arrowForward, color: Colors.grey),
                      onPressed: () async {
                        bool userExists = await Check().checkUsername(textFieldController.text);
                        if (userExists) {
                          Friendship().requestFriendship(textFieldController.text);
                          MyAlertDialogs().showDialogFriendRequestSent(context, textFieldController.text);
                        }
                        else {
                          MyAlertDialogs().showDialogFriendRequestError(context);
                        }
                      }),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Style.Colors.secondColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
