import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestMaker{
  static get(String url)async{
    var pref = await SharedPreferences.getInstance();

    var fetch = pref.getString(url);

    if(fetch != null){
      return jsonDecode(fetch);
    }

    var response = await Dio().get(url);
    if(response.statusCode == 200){
      pref.setString(url, jsonEncode(response.data));
      return response.data;
    }

    return null;
  }
}