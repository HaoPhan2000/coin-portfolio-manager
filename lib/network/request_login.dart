import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkRequestlogin {
  NetworkRequestlogin({required this.jsonBody});
  dynamic jsonBody;

  fetchPosts() async {
    var url = Uri.parse('http://192.168.2.3:8000/Api/User/GetAnUser');
    Map<String, String> headers = {"Content-type": "application/json"};
    jsonBody = jsonEncode(jsonBody);
    var response = await http.post(url, headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return responseData;
    } else {
      print('Lỗi: ${response.statusCode}');
    }
  }
}


