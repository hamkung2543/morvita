import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginsystem/model/insect.dart';

import '../main.dart';
import 'package:http/http.dart' as Http;

class AddInsect extends StatefulWidget {
  const AddInsect({Key? key}) : super(key: key);

  @override
  State<AddInsect> createState() => _AddInsectState();
}

class _AddInsectState extends State<AddInsect> {
  final formKey = GlobalKey<FormState>();
  Insect insect = Insect(
      il_id: 0,
      thainame: " ",
      localname: " ",
      season: " ",
      type: " ",
      order: " ",
      family: " ",
      genus: " ",
      species: " ",
      image: " ");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มแมลงลงห้องสมุด"),
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
                    "ThaiName",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "กรุณาป้อนชื่อให้ถูกต้อง"),
                      ]),
                      keyboardType: TextInputType.text,
                      onSaved: (thainame) {
                        insect.thainame = thainame!;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "LocalName",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "กรุณาป้อนชื่อให้ถูกต้อง"),
                      ]),
                      keyboardType: TextInputType.name,
                      onSaved: (localname) {
                        insect.localname = localname!;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "season",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "กรุณาป้อนฤดูให้ถูกต้อง"),
                      ]),
                      keyboardType: TextInputType.name,
                      onSaved: (season) {
                        insect.season = season!;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "type",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "กรุณาป้อนชนิดให้ถูกต้อง"),
                      ]),
                      keyboardType: TextInputType.name,
                      onSaved: (type) {
                        insect.type = type!;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "order",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                      keyboardType: TextInputType.name,
                      onSaved: (order) {
                        insect.order = order!;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "family",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                      keyboardType: TextInputType.name,
                      onSaved: (family) {
                        insect.family = family!;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "genus",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                      keyboardType: TextInputType.name,
                      onSaved: (genus) {
                        insect.genus = genus!;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "species",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                      keyboardType: TextInputType.name,
                      onSaved: (species) {
                        insect.genus = species!;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "image",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                      keyboardType: TextInputType.name,
                      onSaved: (image) {
                        insect.image = image!;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        "เพิ่มข้อมูลแมลง",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          Add_Insect();
                          formKey.currentState!.reset();
                          Navigator.pop(context);
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

  Future Add_Insect() async {
    HttpOverrides.global = MyHttpOverrides();
    Uri url = Uri.parse('https://morvita.cocopatch.com/insertinsect_lb.php');
    Map data = {
      "il_thainame": insect.thainame,
      "il_localName": insect.localname,
      "il_season": insect.season,
      "il_type": insect.type,
      "il_order": insect.order,
      "il_family": insect.family,
      "il_genus": insect.genus,
      "il_species": insect.species,
      "il_image": insect.image,
    };
    var response = await Http.post(url, body: json.encode(data));
    print(response.body);
  }
}
