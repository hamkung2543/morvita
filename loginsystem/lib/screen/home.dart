import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginsystem/screen/register.dart';
import 'package:http/http.dart' as Http;
import 'package:loginsystem/screen/showinsect_list.dart';

import '../main.dart';
import '../model/profile.dart';
import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

late String email = " ";
late String password = " ";

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register/Login")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                child: Text(
                  "MorVita",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              Text(
                "E-mail",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: "กรุณาป้อนอีเมลดัวย"),
                    EmailValidator(errorText: "กรอกอีเมลให้ถูกต้อง")
                  ]),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (emails) {
                    email = emails!;
                  }),
              SizedBox(
                height: 15,
              ),
              Text(
                "Password",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                validator: RequiredValidator(errorText: "ใส่รหัสผ่านดัวยนะ"),
                obscureText: true,
                onSaved: (passwords) async {
                  password = passwords!;
                },
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          login();

                          formKey.currentState!.reset();
                        }
                      },
                      icon: Icon(Icons.login),
                      label: Text(
                        "เข้าสู่ระบบ",
                        style: TextStyle(fontSize: 20),
                      ))),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterScreen();
                        }));
                      },
                      icon: Icon(Icons.add),
                      label: Text(
                        "สร้างบัญชีผู้ใช้",
                        style: TextStyle(fontSize: 20),
                      ))),
            ]),
          ),
        ),
      ),
    );
  }

  Future login() async {
    HttpOverrides.global = MyHttpOverrides();
    Uri url = Uri.parse('https://morvita.cocopatch.com/login.php');
    Map data = {
      "u_email": email,
      "u_password": password,
    };
    var response = await Http.post(url, body: json.encode(data));
    print(response.body);
    if (json.decode(response.body) == "password true") {
      print("complete");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ShowInsect();
      }));
    } else {
      print("Invalid email or password");
    }
  }
}
