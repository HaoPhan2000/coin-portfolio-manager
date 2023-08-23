import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/transaction_model.dart';
import 'package:flutter_application_1/network/request_get_portfolio.dart';
import 'package:flutter_application_1/network/request_get_transaction.dart';
import 'package:flutter_application_1/pages/Home/coin_detail.dart';
import 'package:flutter_application_1/pages/Portfolio/transaction/add_transaction.dart';
import 'package:flutter_application_1/pages/Portfolio/transaction/list_view_transaction.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Detail extends StatefulWidget {
  const Detail(
      {super.key,
      required this.idCoinFromDB,
      required this.id,
      required this.name,
      required this.symbol,
      required this.image,
      required this.price,
      required this.listCoin,
      required this.idUser});
  final String idCoinFromDB;
  final String id;
  final String name;
  final String symbol;
  final String image;
  final num price;
  final List listCoin;
  final String idUser;
  @override
  State<Detail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Detail> {
  num soLuongConLai = 0;
  num valueCoin = 0;
  num giaMuaTrungBinh = 0;
  num pnl = 0;
  num percentPnl = 0;
  List<dynamic> infoCoin = [];
  List<TransactionModel> listTransactionModel = [];
  var color = const Color.fromARGB(255, 255, 255, 255);
  @override
  void initState() {
    super.initState();
    getDataTransaction();
    getAllDataDetailCoin();
  }

  void getAllDataDetailCoin() {
    for (var element in widget.listCoin) {
      if (element["id"] == widget.id) {
        infoCoin.add(element);
      }
    }
  }

  void getDataTransaction() {
    // get list transacition
    List<TransactionModel> tem = [];
    num quantity = 0;
    NetworkRequestGetcTransaction networkRequestGetcTransaction =
        NetworkRequestGetcTransaction(idCoinFromDB: widget.idCoinFromDB);
    networkRequestGetcTransaction.fetchPosts().then((datafromAPI) {
      if (datafromAPI.isEmpty == true) {
        Navigator.pop(context, 'resetPortlio');
      }
        for (var element in datafromAPI) {
          quantity = num.parse(element["total"]) / num.parse(element["price"]);
          tem.add(TransactionModel(
            id: element["_id"],
            price: num.parse(element["price"]),
            total: num.parse(element["total"]),
            quantity: quantity,
            time: element["time"],
            type: element["type"],
          ));
        }
        listTransactionModel = tem;
      });
  
    // get dữ liệu
    NetworkRequestGetCoin networkRequestGetCoin =
        NetworkRequestGetCoin(idUser: widget.idUser);
    networkRequestGetCoin.fetchPosts().then((datafromAPI) {
      setState(() {
             for (var datafromAPIElement in datafromAPI) {
        if (widget.idCoinFromDB == datafromAPIElement["_id"]) {
          num quantityBuy = 0;
          num quantitySell = 0;
          num tongTienBuy = 0;
          num tongTienSell = 0;
          num tongTienVonVaLoi = 0;

          for (var transactionElement in datafromAPIElement["transactions"]) {
            if (transactionElement["type"] == "Mua") {
              quantityBuy += num.parse(transactionElement["total"]) /
                  num.parse(transactionElement["price"]);
              tongTienBuy += num.parse(transactionElement["total"]);
            }
          }

          for (var transactionElement in datafromAPIElement["transactions"]) {
            if (transactionElement["type"] == "Ban") {
              quantitySell += num.parse(transactionElement["total"]) /
                  num.parse(transactionElement["price"]);
              tongTienSell += num.parse(transactionElement["total"]);
            }
          }
          //đây
          soLuongConLai = quantityBuy - quantitySell;
          tongTienVonVaLoi = soLuongConLai * widget.price + tongTienSell;
          giaMuaTrungBinh = tongTienBuy / quantityBuy;
          valueCoin = soLuongConLai * widget.price;
          pnl = (tongTienVonVaLoi - tongTienBuy);
          percentPnl = pnl / tongTienBuy * 100;

          if (pnl > 0) {
            color = const Color(0xff42be65);
          } else {
            color = const Color(0xfffa4d56);
          }
          break;
        }
      }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, 'resetPortlio');
              },
            ),
            backgroundColor: const Color(0xff151515),
          ),
          body: WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, 'resetWhatList');
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
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.network(widget.image),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 180, 180, 180),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "(${widget.symbol.toUpperCase()})",
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(255, 180, 180, 180),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "\$",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                valueCoin.toStringAsFixed(2),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                soLuongConLai.toStringAsFixed(4),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 180, 180, 180),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.symbol.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(255, 180, 180, 180),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CoinDetail(
                                      listCoin: widget.listCoin,
                                      idUser: widget.idUser,
                                      id: infoCoin.first["id"],
                                      name: infoCoin.first["name"],
                                      symbol: infoCoin.first["symbol"],
                                      image: infoCoin.first["image"],
                                      price: infoCoin.first["current_price"],
                                      priceChange:
                                          infoCoin.first["price_change_24h"],
                                      changePercentage: infoCoin
                                          .first["price_change_percentage_24h"],
                                      marketCapRank:
                                          infoCoin.first["market_cap_rank"],
                                      marketCap: infoCoin.first["market_cap"],
                                      fullyMarketCap: infoCoin
                                          .first["fully_diluted_valuation"],
                                      totalVolume:
                                          infoCoin.first["total_volume"],
                                      high24h: infoCoin.first["high_24h"],
                                      low24h: infoCoin.first["low_24h"],
                                      supply:
                                          infoCoin.first["circulating_supply"],
                                      maxSupply: infoCoin.first["max_supply"],
                                    )));
                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width * 1, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(108, 120, 125, 145),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )),
                          child: const Text(
                            "Thông tin chi tiết",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(108, 120, 125, 145),
                              ),
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: color),
                                      width: 35,
                                      height: 35,
                                      child: Center(
                                        child: pnl >= 0
                                            ? const Icon(
                                                Icons
                                                    .keyboard_double_arrow_up_rounded,
                                                color: Colors.white,
                                              )
                                            : const Icon(
                                                Icons
                                                    .keyboard_double_arrow_down_rounded,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Lỗ/Lãi",
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 180, 180, 180),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          percentPnl.toStringAsFixed(2),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: const TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        const Text(
                                          "%",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        pnl >= 0
                                            ? FaIcon(FontAwesomeIcons.angleUp,
                                                size: 18, color: color)
                                            : FaIcon(
                                                FontAwesomeIcons.angleDown,
                                                size: 18,
                                                color: color,
                                              ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Flexible(
                                            child: Text(
                                          pnl.toStringAsFixed(2),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: pnl >= 0 ? color : color,
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          "\$",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: pnl >= 0 ? color : color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(108, 120, 125, 145),
                              ),
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromARGB(
                                              108, 210, 220, 255),
                                        ),
                                        width: 35,
                                        height: 35,
                                        child: const Center(
                                          child: Text(
                                            "\$",
                                            style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Giá mua trung bình",
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 180, 180, 180),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          giaMuaTrungBinh.toStringAsFixed(2),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: const TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        const Text(
                                          "\$",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Giao dịch",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            Center(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  "Loại",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  "Giá giao dịch",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  "Số lượng",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                            height: listTransactionModel.length * 70,
                            child: ListViewTransaction(
                              price:widget.price,
                              name: widget.name,
                              image: widget.image,
                              listTransactionModel: listTransactionModel,
                              symbol: widget.symbol,
                              getDataTransaction: getDataTransaction,
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => AddTransaction(
                                          idCoinFromDB: widget.idCoinFromDB,
                                          nameCoin: widget.name,
                                          symbol: widget.symbol,
                                          image: widget.image,
                                          price: widget.price,
                                        )));
                            if (result != null) {
                              getDataTransaction();
                            }
                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width * 1, 50)),
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
                          child: const Text(
                            "Thêm giao dịch",
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
              ),
            ),
          )),
    );
  }
}
