import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/coin_card_model.dart';
import 'package:flutter_application_1/pages/Home/coin_card.dart';
import 'package:flutter_application_1/pages/Link_Page/loading_page.dart';

class TopLoser extends StatefulWidget {
  const TopLoser(
      {Key? key,
      required this.topLosers,
      required this.idUser,
      required this.listCoin
  })
      : super(key: key);
  final List<CoinCard> topLosers;
  final String idUser;
  final List listCoin;
 
  @override
  State<TopLoser> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TopLoser> {
  @override
  Widget build(BuildContext context) {
    return widget.topLosers.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.topLosers.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              return CoinItem(
                     listCoin:widget.listCoin,
                idUser: widget.idUser,
                id: widget.topLosers[index].id,
                name: widget.topLosers[index].name,
                symbol: widget.topLosers[index].symbol,
                image: widget.topLosers[index].image,
                price: widget.topLosers[index].price,
                priceChange: widget.topLosers[index].priceChange,
                changePercentage: widget.topLosers[index].changePercentage,
                marketCapRank: widget.topLosers[index].marketCapRank,
                marketCap: widget.topLosers[index].marketCap,
                fullyMarketCap: widget.topLosers[index].fullyMarketCap,
                totalVolume: widget.topLosers[index].totalVolume,
                high24h: widget.topLosers[index].high24h,
                low24h: widget.topLosers[index].low24h,
                supply: widget.topLosers[index].supply,
                maxSupply: widget.topLosers[index].maxSupply,
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
