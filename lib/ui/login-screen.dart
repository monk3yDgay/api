import 'package:api/auth/api-client.dart';
import 'package:api/auth/login-status.dart';
import 'package:api/auth/store.dart';
import 'package:api/models/message.dart';
import 'package:api/models/user.dart';
import 'package:api/ui/register-screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String message = "";

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login"),
      // ),
      body: Container(
        decoration: BoxDecoration(color: Colors.red),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      "Please Login",
                      style: TextStyle(color: Colors.white, fontSize: 0),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "${message}",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            children: [
                              Form(
                                key: key,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.red),
                                      )),
                                      child: TextFormField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          hintText: "Enter Email",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                        ),
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return "Email must not be empty";
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.red),
                                      )),
                                      child: TextFormField(
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                          hintText: "Enter Your Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                        ),
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return "Password must not be empty";
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return RegisterScreen();
                                  }));
                                },
                                child: Text(
                                  "Create New Account",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      if (key.currentState!.validate()) {
                                        User user = User(nameController.text,
                                            passwordController.text);
                                        Message mess =
                                            await ApiClient(Dio()).login(user);
                                        print(mess.token);
                                        if (mess.success) {
                                          Provider.of<Store>(context,
                                                  listen: false)
                                              .setAPi(mess.token);
                                          Provider.of<LoginStatus>(context,
                                                  listen: false)
                                              .setStatus(true);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyApp()));
                                        } else {
                                          setState(() {
                                            this.message = mess.user;
                                          });
                                          print(mess.user);
                                        }
                                      }
                                    },
                                    child: Text("Login",
                                        style: TextStyle(color: Colors.white)),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
