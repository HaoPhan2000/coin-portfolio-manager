import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkRequestDeleteWatchList {
  NetworkRequestDeleteWatchList({required this.idWatchList});
  String idWatchList;
  String url = "";

  fetchPosts() async {
    url = "http://192.168.2.3:8000/Api/Favorite/DeleteFavorite/$idWatchList";
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData);
    } else {
      print('Lỗi: ${response.statusCode}');
    }
  }
}
