import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/model/coin_card_model.dart';
import 'market_cap.dart';
import 'top_gainers.dart';
import 'top_losers.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.listCoin,
    required this.idUser,
  });
  final List listCoin;
  final String idUser;

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  List<CoinCard> marketCaps = [];
  List<CoinCard> topGainers = [];
  List<CoinCard> topLosers = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      var dataMaketcap = widget.listCoin;
      marketCaps = dataMaketcap.map((e) => CoinCard.fromJson(e)).toList();

      var dataTopGainers = widget.listCoin
          .where((element) => element["price_change_percentage_24h"] > 0)
          .toList();
      dataTopGainers.sort((a, b) => b["price_change_percentage_24h"]
          .compareTo(a["price_change_percentage_24h"]));
      //coinCards trả về list theo obj
      topGainers = dataTopGainers.map((e) => CoinCard.fromJson(e)).toList();

      var dataTopLosers = widget.listCoin
          .where((element) => element["price_change_percentage_24h"] < 0)
          .toList();
      dataTopLosers.sort((a, b) => a["price_change_percentage_24h"]
          .compareTo(b["price_change_percentage_24h"]));
      //coinCards trả về list theo obj
      topLosers = dataTopLosers.map((e) => CoinCard.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          children: [
            Container(
              height: 45,
              decoration: const BoxDecoration(
                color: Color(0xff151515),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: const Color.fromRGBO(152, 152, 152, 0.5),
                        borderRadius: BorderRadius.circular(25.0)),
                    labelColor: const Color.fromARGB(255, 255, 255, 255),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: "Roboto",
                    ),
                    unselectedLabelColor:
                        const Color.fromARGB(255, 152, 152, 152),
                    tabs: const [
                      Tab(
                        text: "MARKETCAP",
                      ),
                      Tab(
                        text: "TOP GAINERS",
                      ),
                      Tab(
                        text: "TOP LOSERS",
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: TabBarView(
              children: [
                MarketCap(
                  marketCaps: marketCaps,
                  idUser: widget.idUser,
                  listCoin: widget.listCoin,
                ),
                TopGainers(
                  topGainers: topGainers,
                  idUser: widget.idUser,
                  listCoin: widget.listCoin,
                ),
                TopLoser(
                  topLosers: topLosers,
                  idUser: widget.idUser,
                  listCoin: widget.listCoin,
                )
              ],
            ))
          ],
        ),
      )),
    );
  }
}


//const 