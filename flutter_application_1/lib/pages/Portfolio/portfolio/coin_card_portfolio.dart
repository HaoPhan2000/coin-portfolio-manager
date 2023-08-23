import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Portfolio/transaction/detail.dart';

class CoinItemPortfolio extends StatefulWidget {
  const CoinItemPortfolio(
      {super.key,
      required this.idCoinFromDB,
      required this.id,
      required this.name,
      required this.symbol,
      required this.image,
      required this.price,
      required this.priceChange,
      required this.valueCoin,
      required this.soLuongConLai,
      required this.isPercent,
      required this.totalValuePortfolio,
      required this.listCoin,
      required this.idUser,
       required this.callback});
  final String idCoinFromDB;
  final String id;
  final String name;
  final String symbol;
  final String image;
  final num price;
  final num priceChange;
  final num valueCoin;
  final num soLuongConLai;
  final int isPercent;
  final num totalValuePortfolio;
  final List listCoin;
  final String idUser;
  final Function() callback;
  @override
  State<CoinItemPortfolio> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CoinItemPortfolio> {
  num percent = 0;
  @override
  void initState() {
    super.initState();
    percent = widget.valueCoin / widget.totalValuePortfolio * 100;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 60,
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.network(widget.image),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.symbol.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 180, 180, 180),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        widget.price.toString(),
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "\$",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            widget.priceChange < 0
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: widget.priceChange.toDouble() < 0
                                ? const Color(0xfffa4d56)
                                : const Color(0xff42be65),
                          ),
                        ),
                      ),
                      Text(
                        widget.priceChange.toStringAsFixed(2),
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: widget.priceChange.toDouble() < 0
                                ? const Color(0xfffa4d56)
                                : const Color(0xff42be65)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "%",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: widget.priceChange.toDouble() < 0
                                ? const Color(0xfffa4d56)
                                : const Color(0xff42be65)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        widget.isPercent == 0
                            ? widget.valueCoin.toStringAsFixed(2)
                            : percent.toStringAsFixed(2),
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.isPercent == 0 ? "\$" : "%",
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          widget.soLuongConLai.toStringAsFixed(4),
                          textAlign: TextAlign.end,
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
                        width: 3,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(widget.symbol.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 180, 180, 180),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () async{
       final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Detail(
                idCoinFromDB: widget.idCoinFromDB,
                id: widget.id,
                name: widget.name,
                symbol: widget.symbol,
                image: widget.image,
                price: widget.price,
                listCoin: widget.listCoin,
                idUser: widget.idUser)));
                   if (result != null) {
          widget.callback();
        }
      },
    );
  }
}
