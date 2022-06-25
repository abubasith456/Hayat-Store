import 'package:flutter/material.dart';

// Creating Class named Gfg
class TempModel {
  List<String> value = [];

  void setValue(String value) {
    this.value.add(value);
  }

  List<String> getValue() {
    return value;
  }
  // static TempModel instance = TempModel();

  // TempModel getInstance() {
  //   if (instance != null) {
  //     instance = TempModel();
  //   }

  //   return instance;
  // }

  // // Creating a Field/Property
  // String? email;
  // String? password;
  // String? cnfPassword;

  // // Creating the getter method
  // // to get input from Field/Property
  // String get getEmail {
  //   return email!;
  // }

  // String get getPass {
  //   return password!;
  // }

  // String get getcnfPass {
  //   return cnfPassword!;
  // }

  // // Creating the setter method
  // // to set the input in Field/Property
  // set setEmail(String emailT) {
  //   email = emailT;
  // }

  // set setPass(String pass) {
  //   password = pass;
  // }

  // set setCnfPass(String cnf) {
  //   cnfPassword = cnf;
  // }
}
