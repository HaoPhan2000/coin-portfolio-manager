import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../model/coin_card_model.dart';

class NetworkRequest {
  static const String url =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en";
  static List<dynamic> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    list = list.map((e) => CoinCard.fromJson(e)).toList();
    list = list.map((e) => e.toJson()).toList();
    return list;
  }

  static Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("get api");
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
