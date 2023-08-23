import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/request_get_list_all_coin.dart';
import 'package:flutter_application_1/pages/MyHomePage/my_home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static String routeName = "/splash";

  @override
  State<SplashPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplashPage> {
  List<dynamic> listCoin = [];
  @override
  void initState() {
    super.initState();
    NetworkRequest.fetchPosts().then((datafromAPI) {
      setState(() {
        listCoin = datafromAPI;
      });
    });
    
    // Timer.periodic(
    //     const Duration(minutes: 5),
    //     (timer) => NetworkRequest.fetchPosts().then((datafromAPI) {
    //           print("request lại thành công");
    //           setState(() {
    //             listCoin = datafromAPI;
    //           });
    //         }));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds:1000), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(listCoin: listCoin)));
    });
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/logo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ));
  }
}
