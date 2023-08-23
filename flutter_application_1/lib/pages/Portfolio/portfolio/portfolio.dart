import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/model/portfolio_model.dart';
import 'package:flutter_application_1/network/request_get_portfolio.dart';
import 'package:flutter_application_1/pages/Portfolio/portfolio/list_view_portfolio.dart';
import 'package:flutter_application_1/pages/Portfolio/portfolio/pie_chart.dart';
import 'package:flutter_application_1/pages/Portfolio/portfolio/select_coin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key, required this.listCoin, required this.idUser});
  final List listCoin;
  final String idUser;
  @override
  State<Portfolio> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Portfolio> {
  bool displayNumber = true;
  final List<bool> _selections = [true, false];
  num totalValuePortfolio = 0;
  List<dynamic> portfolioList = [];
  List<PortfolioModel> listPortfolioModel = [];
  int isPercent = 0;
  @override
  void initState() {
    super.initState();
    getDataPortfolio();
  }

  void getDataPortfolio() {
    NetworkRequestGetCoin networkRequestGetCoin =
        NetworkRequestGetCoin(idUser: widget.idUser);
    networkRequestGetCoin.fetchPosts().then((datafromAPI) {
      setState(() {
        List<PortfolioModel> tem = [];
        for (var datafromAPIElement in datafromAPI) {
          for (var listCoinElement in widget.listCoin) {
            if (listCoinElement["id"] == datafromAPIElement["id"]) {
              num quantityBuy = 0;
              num quantitySell = 0;

              for (var transactionElement
                  in datafromAPIElement["transactions"]) {
                if (transactionElement["type"] == "Mua") {
                  quantityBuy += num.parse(transactionElement["total"]) /
                      num.parse(transactionElement["price"]);
                }
              }

              for (var transactionElement
                  in datafromAPIElement["transactions"]) {
                if (transactionElement["type"] == "Ban") {
                  quantitySell += num.parse(transactionElement["total"]) /
                      num.parse(transactionElement["price"]);
                }
              }

              tem.add(PortfolioModel(
                  idCoinFromDB: datafromAPIElement["_id"],
                  id: listCoinElement["id"],
                  name: listCoinElement["name"],
                  symbol: listCoinElement["symbol"],
                  image: listCoinElement["image"],
                  price: listCoinElement["current_price"],
                  priceChange: listCoinElement["price_change_percentage_24h"],
                  valueCoin: (quantityBuy - quantitySell) *
                      listCoinElement["current_price"],
                  soLuongConLai: quantityBuy - quantitySell));
              break;
            }
          }
        }
        listPortfolioModel = tem;
        portfolioList = tem.map((e) => e.toJson()).toList();

        if (portfolioList.isEmpty) {
          totalValuePortfolio = 0;
        } else {
          totalValuePortfolio = 0;
          for (var element in portfolioList) {
            totalValuePortfolio += element["valueCoin"];
          }
        }
      });
    });
  }

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
        child: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "My Portfolio",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Số dư hiện tại",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              color: Color.fromARGB(255, 180, 180, 180),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text(
                                "\$",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  displayNumber == true
                                      ? totalValuePortfolio.toStringAsFixed(2)
                                      : "******",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                      Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                displayNumber = !displayNumber;
                              });
                            },
                            splashColor: const Color(0xff151515),
                            iconSize: 18,
                            icon: FaIcon(
                              displayNumber == true
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: PieChart(
                  listCoin: widget.listCoin,
                  idUser: widget.idUser,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tài sản của bạn",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      Center(
                        child: ToggleButtons(
                          onPressed: (int index) {
                            setState(() {
                              // The button that is tapped is set to true, and the others to false.
                              for (int i = 0; i < _selections.length; i++) {
                                _selections[i] = i == index;
                              }
                            });
                            isPercent = index;
                            if (isPercent == 1) {}
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          fillColor: const Color.fromARGB(255, 80, 80, 80),
                          selectedColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          splashColor: const Color.fromARGB(255, 100, 100, 100),
                          constraints: const BoxConstraints(
                            minHeight: 22,
                            minWidth: 40,
                          ),
                          isSelected: _selections,
                          children: const <Widget>[
                            Text(
                              '\$',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '%',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Tài sản",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 180, 180, 180),
                        ),
                      )),
                      Expanded(
                          child: Text(
                        "24H Price",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 180, 180, 180),
                        ),
                      )),
                      Expanded(
                          child: Text(
                        "Số lượng nắm giữ",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 180, 180, 180),
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: listPortfolioModel.length.toDouble() * 60,
                    child: ListViewPortfolio(
                      callback: getDataPortfolio,
                      listPortfolioModel: listPortfolioModel,
                      isPercent: isPercent,
                      totalValuePortfolio: totalValuePortfolio,
                      listCoin: widget.listCoin,
                      idUser: widget.idUser,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final result =
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SelectCoin(
                                    idUser: widget.idUser,
                                    listCoin: widget.listCoin,
                                  )));
                      if (result != null) {
                        getDataPortfolio();
                      }
                    },
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 1, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(255, 204, 0, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                              color: Color.fromRGBO(255, 204, 0, 1),
                            ),
                          ),
                        )),
                    child: const Text(
                      "Thêm tài sản mới",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 15,
                        color: Color(0xff151515),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
