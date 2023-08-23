import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/request_add_watchlist.dart';
import 'package:flutter_application_1/network/request_delete_watchlist.dart';
import 'package:flutter_application_1/network/request_get_watchlist.dart';
import 'package:flutter_application_1/pages/Home/chart.dart';

class CoinDetail extends StatefulWidget {
  const CoinDetail({
    super.key,
    required this.listCoin,
    required this.idUser,
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.price,
    required this.priceChange,
    required this.changePercentage,
    required this.marketCapRank,
    required this.marketCap,
    required this.fullyMarketCap,
    required this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.supply,
    required this.maxSupply,
  });
  final List listCoin;
  final String idUser;
  final String id;
  final String name;
  final String symbol;
  final String image;
  final num price;
  final num priceChange;
  final num changePercentage;
  final num marketCapRank;
  final num? marketCap;
  final num? fullyMarketCap;
  final num? totalVolume;
  final num high24h;
  final num low24h;
  final num? supply;
  final num? maxSupply;

  @override
  State<CoinDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CoinDetail> {
  bool isWatchList = false;
  Map coin = {};
  List<dynamic> watchlist = [];
  String idWatchList = "";
  @override
  void initState() {
    super.initState();
    if (widget.idUser.isEmpty == false) {
      NetworkRequestWatchList networkRequestWatchList =
          NetworkRequestWatchList(idUser: widget.idUser);
      networkRequestWatchList.fetchPosts().then((datafromAPI) {
        setState(() {
          findMatchingElements(List<dynamic> a, List<dynamic> b) {
            List<dynamic> result = [];
            for (var element in a) {
              if (b.any((bElement) => bElement['id'] == element['id'])) {
                result.add(element);
              }
            }
            return result;
          }

          watchlist = findMatchingElements(widget.listCoin, datafromAPI);

          for (var element in datafromAPI) {
            if (element['id'] == widget.id) {
              idWatchList = element['_id'];
            }
          }
        });
        checkWatchList();
      });
    }
  }



  void checkWatchList() {
    for (var element in watchlist) {
      if (element['id'] == widget.id) {
        isWatchList = true;
      }
    }
  }

  String addCommasToNumber(num number) {
    String str = number.toString();
    int len = str.length;
    if (len <= 3) {
      return str;
    } else {
      int firstCommaIndex = len % 3;
      if (firstCommaIndex == 0) {
        firstCommaIndex = 3;
      }
      String result = str.substring(0, firstCommaIndex);
      for (int i = firstCommaIndex; i < len; i += 3) {
        result += ',${str.substring(i, i + 3)}';
      }
      return result;
    }
  }

  String addCommasToNumberForString(String number) {
    String str = number;
    int len = str.length;
    if (len <= 3) {
      return str;
    } else {
      int firstCommaIndex = len % 3;
      if (firstCommaIndex == 0) {
        firstCommaIndex = 3;
      }
      String result = str.substring(0, firstCommaIndex);
      for (int i = firstCommaIndex; i < len; i += 3) {
        result += ',${str.substring(i, i + 3)}';
      }
      return result;
    }
  }

  addWatchList() {
    coin = {"name": widget.name, "id": widget.id, "user": widget.idUser};
    NetworkRequestAddWatchList networkRequestAddWatchList =
        NetworkRequestAddWatchList(jsonBody: coin);
    networkRequestAddWatchList.fetchPosts();
    setState(() {
      isWatchList = !isWatchList;
    });
  }

  deleteWatchList() {
    
    NetworkRequestDeleteWatchList networkRequestDeleteWatchList=
    NetworkRequestDeleteWatchList(idWatchList:idWatchList );
    networkRequestDeleteWatchList.fetchPosts();
    setState(() {
      isWatchList = !isWatchList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        color: const Color(0xff151515),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: const Color(0xff151515),
                pinned: true,
                expandedHeight: 350,
                centerTitle: true,
                actions: [
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: widget.idUser.isEmpty == true
                          ? Container()
                          : IconButton(
                              icon: isWatchList
                                  ? const Icon(
                                      Icons.turned_in_outlined,
                                    )
                                  : const Icon(
                                      Icons.turned_in_not,
                                    ),
                              iconSize: 28,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              onPressed: () {
                                if (isWatchList) {
                                  deleteWatchList();
                                } else {
                                  addWatchList();
                                }
                              },
                            ))
                ],
                title: Text(
                  widget.name,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                    ),
                    child: Container(
                        color: const Color(0xff151515),
                        width: double.infinity,
                        height: 250,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: double.infinity,
                                height: 30,
                                color: const Color(0xff151515),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              widget.price.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: const TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 1),
                                        const Text(
                                          "\$",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    )),
                                    Expanded(
                                        child: Container(
                                      color: const Color(0xff151515),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              widget.priceChange.toDouble() < 0
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up,
                                              color: widget.priceChange >= 0
                                                  ? const Color(0xff42be65)
                                                  : const Color(0xfffa4d56),
                                            ),
                                            Flexible(
                                              child: Text(
                                                widget.priceChange
                                                    .toDouble()
                                                    .toStringAsFixed(3),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: widget.priceChange >= 0
                                                      ? const Color(0xff42be65)
                                                      : const Color(0xfffa4d56),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "\$",
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: widget.priceChange >= 0
                                                    ? const Color(0xff42be65)
                                                    : const Color(0xfffa4d56),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            Chart(
                                id: widget.id, priceChange: widget.priceChange),
                          ],
                        )),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  width: double.infinity,
                  height: 700,
                  color: const Color(0xff151515),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 10, right: 10, left: 10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 152, 152, 152),
                                    // color: Colors.black.withAlpha(15),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(children: [
                                const Text(
                                  "High",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    addCommasToNumber(widget.high24h),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: const TextStyle(
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xff42be65),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 10, right: 10, left: 10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 152, 152, 152),
                                    // color: Colors.black.withAlpha(15),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(children: [
                                const Text(
                                  "Low",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    addCommasToNumber(widget.low24h),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: const TextStyle(
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xfffa4d56),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 30, bottom: 10, right: 10, left: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 152, 152, 152),
                              // color: Colors.black.withAlpha(15),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(children: [
                          const Text(
                            "Market Cap",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.marketCap == null
                                  ? widget.marketCap.toString()
                                  : addCommasToNumber(widget.marketCap!),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 30, bottom: 10, right: 10, left: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 152, 152, 152),
                              // color: Colors.black.withAlpha(15),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(children: [
                          const Text(
                            "Fully Market Cap",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.fullyMarketCap == null
                                  ? widget.fullyMarketCap.toString()
                                  : addCommasToNumber(widget.fullyMarketCap!),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 30, bottom: 10, right: 10, left: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 152, 152, 152),
                              // color: Colors.black.withAlpha(15),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(children: [
                          const Text(
                            "Supply",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.supply == null
                                  ? widget.supply.toString()
                                  : addCommasToNumberForString(widget.supply!
                                      .toDouble()
                                      .toStringAsFixed(0)),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 30, bottom: 10, right: 10, left: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 152, 152, 152),
                              // color: Colors.black.withAlpha(15),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(children: [
                          const Text(
                            "Max Supply",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.maxSupply == null
                                  ? widget.maxSupply.toString()
                                  : addCommasToNumberForString(widget.maxSupply!
                                      .toDouble()
                                      .toStringAsFixed(0)),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ]))
            ],
          ),
        ),
      )),
    );
  }
}
