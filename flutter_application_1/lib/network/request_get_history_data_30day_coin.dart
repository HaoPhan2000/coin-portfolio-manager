import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkRequestHistoryData30Day {
  NetworkRequestHistoryData30Day({
    required this.id,
  });
  String id;
  String url = "";
  List<dynamic> parsePost(String responseBody) {
    List<dynamic> priceMonth = [];
    Map<String, dynamic> data = json.decode(responseBody);
    List<dynamic> prices = data['prices'];
    for (var element in prices) {
      String tem = element[1].toStringAsFixed(2);
      priceMonth.add(num.parse(tem));
    }
    return priceMonth;
  }

  Future<List<dynamic>> fetchPosts() async {
    url =
        "https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=usd&days=30";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return compute(parsePost, response.body);
    } else {
        throw Exception('Lỗi: ${response.statusCode}');
    }
  }
}
