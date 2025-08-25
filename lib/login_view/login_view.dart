import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/login_view/register_view.dart';
import '../../view_models/app_view_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../task_viewer/models/user_model.dart';
import '../task_viewer/views/task_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  String? errorMessage;
  bool isLoading = false;

  Future sign_in() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    String url = 'http://10.0.2.2/todolist/login.php';
    final response = await http.post(
      Uri.parse(url),
      body: {"email": email.text, "password": pass.text},
    );
    print(response.body);
    var responseData = json.decode(response.body);

    if (responseData['status'] == 'success') {
      var userData = responseData['data'];

      final viewModel = Provider.of<AppViewModel>(context, listen: false);
      viewModel.setUserData(
        userId: userData['user_id'].toString(),
        username: userData['name']?.toString() ?? "user",
        email: userData['email']?.toString() ?? email.text,
      );

      await User.setSignIn(true);
      await User.setUserData(
        userId: userData['user_id'].toString(),
        username: userData['name']?.toString() ?? "user",
        email: userData['email']?.toString() ?? email.text,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TaskPage()));
    } else {
      setState(() {
        errorMessage = responseData['message'].toString();
        isLoading = false;
      });
      formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppViewModel().colorLevel2,
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome !',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email.';
                        } else if (errorMessage != null) {
                          return 'Wrong password/email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Please enter valid email.';
                        }
                        return null;
                      },
                      controller: email,
                      onChanged: (value) {
                        if (errorMessage != null) {
                          setState(() {
                            errorMessage = null;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password.';
                        } else if (errorMessage != null) {
                          return 'Wrong password/email';
                        }
                        return null;
                      },
                      controller: pass,
                      onChanged: (value) {
                        if (errorMessage != null) {
                          setState(() {
                            errorMessage = null;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppViewModel().colorLevel3,
                        foregroundColor: AppViewModel().colorLevel1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              bool pass = formKey.currentState!.validate();
                              if (pass) {
                                sign_in();
                              }
                            },
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: AppViewModel().colorLevel1,
                            )
                          : const Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: const Text("Didn't have any Account? Sign Up now"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
