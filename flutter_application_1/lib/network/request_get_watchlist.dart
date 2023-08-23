import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkRequestWatchList {
  NetworkRequestWatchList({required this.idUser});
  String idUser;
  String url = "";

  List<dynamic> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    return list;
  }

  Future<List<dynamic>> fetchPosts() async {
    url = "http://192.168.2.3:8000/Api/Favorite/GetFavorite/$idUser";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return compute(parsePost, response.body);
    } else {
      if (response.statusCode == 404) {
        throw Exception('Not Found');
      } else {
        throw Exception('Can\'t get');
      }
    }
  }
}
