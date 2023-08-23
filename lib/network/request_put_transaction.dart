import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkRequestUpDateTracsaction {
  NetworkRequestUpDateTracsaction({required this.jsonBody,required this.idTransaction});
  dynamic jsonBody;
  String idTransaction;

  fetchPosts() async {
    var url = Uri.parse('http://192.168.2.3:8000/Api/Transaction/PutTransaction/$idTransaction');
    Map<String, String> headers = {"Content-type": "application/json"};
    jsonBody = jsonEncode(jsonBody);
    var response = await http.put(url, headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData);
    } else {
      print('Lỗi: ${response.statusCode}');
    }
  }
}