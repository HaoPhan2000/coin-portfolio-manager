import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkRequestDeleteTransaction{
  NetworkRequestDeleteTransaction({required this.idTransaction});
  String idTransaction;
  String url = "";

  fetchPosts() async {
    url = "http://192.168.2.3:8000/Api/Transaction/DeleteTransaction/$idTransaction";
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData);
    } else {
      print('Lỗi: ${response.statusCode}');
    }
  }
}