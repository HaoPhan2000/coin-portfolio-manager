import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkRequestDeleteCoin{
  NetworkRequestDeleteCoin({required this.idCoinFromDB});
  String idCoinFromDB;
  String url = "";

  fetchPosts() async {
    url = "http://192.168.2.3:8000/Api/Coin/DeleteCoin/$idCoinFromDB";
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData);
    } else {
      print('Lỗi: ${response.statusCode}');
    }
  }
}