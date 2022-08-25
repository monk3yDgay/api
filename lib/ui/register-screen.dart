import 'package:api/auth/api-client.dart';
import 'package:api/auth/store.dart';
import 'package:api/models/message.dart';
import 'package:api/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login-screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  String message = "";
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();

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
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      "Please Register",
                      style: TextStyle(color: Colors.white, fontSize: 0),
                    ),
                  ),
                  SizedBox(height: 15),
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
                                          hintText: "Enter Your Name",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                        ),
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return "Name must not be empty";
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
                                        controller: emailController,
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
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  "Please Login",
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
                                        Message mess = await ApiClient(Dio())
                                            .register(user);
                                        print(mess.token);
                                        if (mess.token != "") {
                                          Provider.of<Store>(context,
                                                  listen: false)
                                              .setAPi(mess.token);
                                          setState(() {
                                            message = mess.user;
                                          });
                                        }
                                      }
                                    },
                                    child: Text("Register",
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
