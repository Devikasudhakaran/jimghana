import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../constants/service_urls.dart';
import '../../utils/print_statements.dart';



class JavaApiProvider {
  final String _baseUrl = ServiceUrls.apiBaseUrlForJava;

  Future<dynamic> getData(
      String serviceName, Map paramBody, String controllerName) async {
    dynamic responseJson;
    print('service');
    try {
      var response = await http.post(
        Uri.parse('https://lmckmrl.kokonet.in/customerservice/addVehicleData'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(paramBody),
      );
      printInDebug(_baseUrl + controllerName + serviceName);
      if (response.statusCode == 200) {
        print('service2');
        responseJson = jsonDecode(response.body);
        return responseJson;
      } else {
        return null;
      }
    } on SocketException {
      return Fluttertoast.showToast(
        msg: "You are now offline",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 18.0,
      );
    }
  }
}