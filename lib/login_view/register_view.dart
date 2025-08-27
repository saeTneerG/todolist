import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../view_models/app_view_model.dart';
import '../task_viewer/models/user_model.dart';
import '../task_viewer/views/task_page.dart';
import 'login_view.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  String? emailMessageError;
  bool isLoading = false;

  Future sign_up() async {

    setState(() {
      emailMessageError = null;
      isLoading = true;
    });
    print("name: ${name.text}");
    print("email: ${email.text}");
    print("pass: ${pass.text}");
    String url = 'http://10.0.2.2/todolist/register.php';
    final response = await http.post(Uri.parse(url), body: {
      "name": name.text,
      "password": pass.text,
      "email": email.text,
    });
    var data = json.decode(response.body);
    print("data: $data");

    if (data['message'] == 'Email already exists.') {
      setState(() {
        emailMessageError = "This email already exists.";
        isLoading = false;
      });
      formKey.currentState!.validate();
    } else {
      await User.setSignIn(true);
      final viewModel = Provider.of<AppViewModel>(context, listen: false);
      viewModel.setUserData(
        userId: data['data']['user_id'].toString(),
        username: data['data']['name']?.toString() ?? "user",
        email: data['data']['email']?.toString() ?? "email",
      );
      await User.setUserData(
        userId: data['user_id'].toString(),
        username: data['name']?.toString() ?? "user",
        email: data['email']?.toString() ?? email.text,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TaskPage()));
    }
  }

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
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Name field
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter name.';
                        }
                        return null;
                      },
                      controller: name,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Email field
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your E-Mail',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email.';
                        } else if (emailMessageError != null) {
                          return emailMessageError;
                        } else if (!EmailValidator.validate(value)) {
                          return 'Please enter valid email.';
                        }
                        return null;
                      },
                      controller: email,
                      onChanged: (value) {
                        if (emailMessageError != null) {
                          setState(() {
                            emailMessageError = null;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Password field
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Create your Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password.';
                        }
                        return null;
                      },
                      controller: pass,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Confirm Password field
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm your Password',
                      ),
                      validator: (value) {
                        if (pass.text.isNotEmpty) {
                          if (value!.isEmpty) {
                            return 'Please enter your password again.';
                          } else if (value != pass.text) {
                            return 'Password does not match.';
                          }
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppViewModel().colorLevel3,
                          foregroundColor: AppViewModel().colorLevel1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: isLoading ? null : () {
                        bool pass = formKey.currentState!.validate();
                        if (pass) {
                          sign_up();
                        }
                      },
                      child: isLoading ? CircularProgressIndicator(
                        color: AppViewModel().colorLevel1,
                      ) : const Text(
                        'Sign up',
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: const Text("Already have an Account? Sign in"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
