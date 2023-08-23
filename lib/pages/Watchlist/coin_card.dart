import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Watchlist/coin_detail.dart';

class CoinItemWatchList extends StatefulWidget {
  const CoinItemWatchList(
      {super.key,
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
      required this.callback});
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
  final Function() callback;
  @override
  State<CoinItemWatchList> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CoinItemWatchList> {
  String resetWatchList = "";
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 70,
        color: const Color(0xff151515),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: Image.network(widget.image.toString()),
            ),
            Expanded(
              child: Container(
                color: const Color(0xff151515),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
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
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(152, 152, 152, 0.5),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              widget.marketCapRank
                                  .toDouble()
                                  .floor()
                                  .toString(),
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              widget.symbol.toUpperCase(),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color(0xff151515),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            fontSize: 18,
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
                            fontSize: 18,
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
                              widget.changePercentage.toDouble() < 0
                                  ? Icons.arrow_drop_down
                                  : Icons.arrow_drop_up,
                              color: widget.changePercentage.toDouble() < 0
                                  ? const Color(0xfffa4d56)
                                  : const Color(0xff42be65),
                            ),
                          ),
                        ),
                        Text(
                          widget.changePercentage.toDouble().toStringAsFixed(2),
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: widget.changePercentage.toDouble() < 0
                                ? const Color(0xfffa4d56)
                                : const Color(0xff42be65),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "%",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: widget.changePercentage.toDouble() < 0
                                ? const Color(0xfffa4d56)
                                : const Color(0xff42be65),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () async {
        final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CoinDetailWatchList(
                  listCoin: widget.listCoin,
                  idUser: widget.idUser,
                  id: widget.id,
                  name: widget.name,
                  symbol: widget.symbol,
                  image: widget.image,
                  price: widget.price,
                  priceChange: widget.priceChange,
                  changePercentage: widget.changePercentage,
                  marketCapRank: widget.marketCapRank,
                  marketCap: widget.marketCap,
                  fullyMarketCap: widget.fullyMarketCap,
                  totalVolume: widget.totalVolume,
                  high24h: widget.high24h,
                  low24h: widget.low24h,
                  supply: widget.supply,
                  maxSupply: widget.maxSupply,
                )));
        if (result != null) {
          widget.callback();
        }
      },
    );
  }
}
