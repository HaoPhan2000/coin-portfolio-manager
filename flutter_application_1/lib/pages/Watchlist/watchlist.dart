import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/Watchlist/list_watchlist.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key, required this.listCoin, required this.idUser});
  final List listCoin;
  final String idUser;

  @override
  State<Watchlist> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Watchlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: const Color(0xff151515),
                title: const Text(
                  'Confirm',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 18,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                content: const Text('Do you want to exit the app?',
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    )),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(255, 204, 0, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(255, 204, 0, 1),
                                  ),
                                ),
                              )),
                          onPressed: () {
                            SystemChannels.platform.invokeMethod<void>(
                                'SystemNavigator.pop'); // Thoát khỏi ứng dụng
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16,
                              color: Color(0xff151515),
                            ),
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(255, 204, 0, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(255, 204, 0, 1),
                                  ),
                                ),
                              )),
                          onPressed: () {
                            Navigator.pop(context); // Đóng hộp thoại xác nhận
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16,
                              color: Color(0xff151515),
                            ),
                          )),
                    ],
                  )
                ],
              );
            },
          );
          return false;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Watch list",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            ListWatchlist(
              listCoin: widget.listCoin,
              idUser: widget.idUser,
            )
          ],
        ),
      ),
    );
  }
}
