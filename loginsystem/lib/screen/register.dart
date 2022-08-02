import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginsystem/model/profile.dart';
import 'package:http/http.dart' as Http;

import '../main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(
      email: '',
      password: '',
      name: '',
      lastname: '',
      favorite: '',
      u_id: 0,
      image: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สร้างบัญชีผู้ใช้"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      onSaved: (email) {
                        profile.email = email!;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    validator:
                        RequiredValidator(errorText: "ใส่รหัสผ่านดัวยนะ"),
                    obscureText: true,
                    onSaved: (password) async {
                      profile.password = password!;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    validator: RequiredValidator(errorText: "ใส่ชื่อแหม่สู"),
                    keyboardType: TextInputType.name,
                    onSaved: (name) async {
                      profile.name = name!;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "LastName",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    onSaved: (lastname) async {
                      profile.lastname = lastname!;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "ความชอบ",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    onSaved: (favorite) async {
                      profile.favorite = favorite!;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        "สมัครสมาชิก",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          print(
                              "email = ${profile.email} password = ${profile.password} name = ${profile.name} lastname = ${profile.lastname}");
                          register();
                          formKey.currentState!.reset();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future register() async {
    HttpOverrides.global = MyHttpOverrides();
    Uri url = Uri.parse('https://morvita.cocopatch.com/signup.php');
    Map data = {
      "u_email": profile.email,
      "u_password": profile.password,
      "u_name": profile.name,
      "u_lastname": profile.lastname,
      "u_pic": "",
      "u_favorite": profile.favorite
    };
    var response = await Http.post(url, body: json.encode(data));
    print(response.body);
  }
}
