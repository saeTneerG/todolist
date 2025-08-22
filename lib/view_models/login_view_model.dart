import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/task_viewer/views/task_page.dart';
import '../login_view/login_view.dart';
import '../task_viewer/models/user_model.dart';

class CheckLoginState extends StatefulWidget {
  const CheckLoginState({super.key});

  @override
  State<CheckLoginState> createState() => _CheckLoginStateState();
}

class _CheckLoginStateState extends State<CheckLoginState> {
  Future checkLogin () async {
    bool? signIn = await User.getSignIn();
    if (signIn == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TaskPage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  void initState () {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
