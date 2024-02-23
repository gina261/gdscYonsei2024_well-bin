import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future httpGetFoodList({required String path}) async {
  String baseUrl = 'http://35.238.24.83$path';

  try {
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
    });

    try {
      // Check if the response body is null
      if (response.body.isEmpty) {
        return {'statusCode': 490};
      }

      // Decode the response body
      dynamic responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint('FoodList response: $responseBody');

      if (responseBody is List && responseBody.isNotEmpty) {
        return {'statusCode': response.statusCode, 'data': responseBody};
      } else {
        return {'statusCode': 490};
      }
    } catch (e) {
      debugPrint("httpGet error: $e");
      return {'statusCode': 490};
    }
  } catch (e) {
    debugPrint("httpGet error: $e");
    return {'statusCode': 503};
  }
}

Future httpGetNutrient({required String foodName}) async {
  String baseUrl = 'http://35.238.24.83/nutrition/?food=$foodName';

  try {
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
    });

    try {
      // Check if the response body is null
      if (response.body.isEmpty) {
        return {'statusCode': 490};
      }

      // Decode the response body
      dynamic responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint('GetNutrient response: $responseBody');

      // if (responseBody is List && responseBody.isNotEmpty)
      if (responseBody.isNotEmpty) {
        return {'statusCode': response.statusCode, 'data': responseBody};
      } else {
        return {'statusCode': 490};
      }
    } catch (e) {
      debugPrint("httpGet error: $e");
      return {'statusCode': 490};
    }
  } catch (e) {
    debugPrint("httpGet error: $e");
    return {'statusCode': 503};
  }
}

Future httpGetRecycleList({required String path}) async {
  String baseUrl = 'http://35.238.24.83/recycle/?img_path=$path';

  try {
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
    });

    try {
      // check if the response body is null
      if (response.body.isEmpty) {
        return {'statusCode': 490};
      }

      // decode the response body
      dynamic responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint('RecycleList response: $responseBody');

      if (responseBody.isNotEmpty) {
        return {'statusCode': response.statusCode, 'data': responseBody};
      } else {
        return {'statusCode': 490};
      }
    } catch (e) {
      debugPrint("httpGet error: $e");
      return {'statusCode': 490};
    }
  } catch (e) {
    debugPrint('httpGet error: $e');
    return {'statusCode': 503};
  }
}
