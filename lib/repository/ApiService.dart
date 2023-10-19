

import 'dart:convert';
import 'dart:io';
import 'package:assignment/post/model/user_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'app_exception.dart';
import 'constants/ApiConstants.dart';


class ApiService {


  postApiCall(var apiUrl ,var dataObj,BuildContext context) async{

    try {
      var url = Uri.parse(ApiConstants.baseUrl + apiUrl);
      Response response = await post(
          Uri.parse('$url'),
          body: dataObj,
      );

      if (kDebugMode) {
        print("response code ${response.statusCode}");
      }
      if (response.statusCode == 200) {
        var data  = jsonDecode(response.body.toString());
        if (kDebugMode) {
          print("api data is $data");
        }
        return data;
      }
      else {
        Fluttertoast.showToast(
            msg: "Something wrong",  // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM,    // location
            timeInSecForIosWeb: 2               // duration
        );
      }
    } on SocketException{
      Fluttertoast.showToast(
          msg: "Please check your internet connection",  // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM,    // location
          timeInSecForIosWeb: 2               // duration
      );
      throw FetchDataException("No internet connection");

    }on BadRequestException{
      Fluttertoast.showToast(
          msg: "your internet seems slow. please try again",  // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM,    // location
          timeInSecForIosWeb: 2               // duration
      );

      throw BadRequestException("your internet seems slow. please try again");

    }on FetchDataException{
      Fluttertoast.showToast(
          msg: "your internet seems slow. please try again",  // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM,    // location
          timeInSecForIosWeb: 2               // duration
      );
      throw FetchDataException("error occured while communicating with server");
    }
    catch(e){
      throw Exception("$e");
    }
  }



  getApiCall(var apiUrl,BuildContext context) async {

    try {
      var url = Uri.parse(ApiConstants.baseUrl + apiUrl);

      Response response = await get(Uri.parse('$url'),);

      if (kDebugMode) {
        print("response code ${response.statusCode}");
      }
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());


        return data;
      }
    } on SocketException {
      Fluttertoast.showToast(
          msg: "No internet connection", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM, // location
          timeInSecForIosWeb: 2 // duration
      );
      throw FetchDataException("No internet connection");
    } on BadRequestException {
      Fluttertoast.showToast(
          msg: "your internet seems slow. please try again", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM, // location
          timeInSecForIosWeb: 2 // duration
      );

      throw BadRequestException("your internet seems slow. please try again");
    } on FetchDataException {
      Fluttertoast.showToast(
          msg: "your internet seems slow. please try again", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM, // location
          timeInSecForIosWeb: 2 // duration
      );
      throw FetchDataException("error occured while communicating with server");
    }
    catch (e) {
      throw Exception("$e");
    }
  }
}