import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'watchlist.dart';

class CheckUserWatchlist extends StatefulWidget {
  const CheckUserWatchlist(
      {super.key, required this.listCoin, required this.idUser});
  final List listCoin;
  final String idUser;
  @override
  State<CheckUserWatchlist> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CheckUserWatchlist> {
  @override
  Widget build(BuildContext context) {
    if (widget.idUser.isEmpty == true) {
      return WillPopScope(
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
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(126, 80, 80, 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Đăng nhập để sử dụng tính năng này",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(255, 204, 0, 1),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                            color: Color.fromRGBO(255, 204, 0, 1),
                          ),
                        ),
                      )),
                  child: const Text(
                    "Đăng nhập",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      color: Color(0xff151515),
                    ),
                  ))
            ],
          ),
        ),
      );
    } else {
      return Watchlist(
        listCoin: widget.listCoin,
        idUser: widget.idUser,
      );
    }
  }
}
