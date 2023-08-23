import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Home/coin_card.dart';
import 'package:flutter_application_1/model/coin_card_model.dart';
import 'package:flutter_application_1/pages/Link_Page/loading_page.dart';

class MarketCap extends StatefulWidget {
  const MarketCap({
    Key? key,
    required this.marketCaps,
    required this.idUser,
     required this.listCoin
  }) : super(key: key);
  final List<CoinCard> marketCaps;
  final String idUser;
   final List listCoin;

  @override
  State<MarketCap> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MarketCap> {
  @override
  Widget build(BuildContext context) {
    return widget.marketCaps.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.marketCaps.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              return CoinItem(
                listCoin: widget.listCoin,
                idUser: widget.idUser,
                id: widget.marketCaps[index].id,
                name: widget.marketCaps[index].name,
                symbol: widget.marketCaps[index].symbol,
                image: widget.marketCaps[index].image,
                price: widget.marketCaps[index].price,
                priceChange: widget.marketCaps[index].priceChange,
                changePercentage: widget.marketCaps[index].changePercentage,
                marketCapRank: widget.marketCaps[index].marketCapRank,
                marketCap: widget.marketCaps[index].marketCap,
                fullyMarketCap: widget.marketCaps[index].fullyMarketCap,
                totalVolume: widget.marketCaps[index].totalVolume,
                high24h: widget.marketCaps[index].high24h,
                low24h: widget.marketCaps[index].low24h,
                supply: widget.marketCaps[index].supply,
                maxSupply: widget.marketCaps[index].maxSupply,
              );
            },
          )
        : const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: LoadingPage(),
            ),
          );
  }
}
