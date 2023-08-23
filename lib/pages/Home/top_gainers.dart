import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/coin_card_model.dart';
import 'package:flutter_application_1/pages/Home/coin_card.dart';
import 'package:flutter_application_1/pages/Link_Page/loading_page.dart';

class TopGainers extends StatefulWidget {
  const TopGainers(
      {Key? key,
      required this.topGainers,
      required this.idUser,
      required this.listCoin
    })
      : super(key: key);
  final List<CoinCard> topGainers;
  final String idUser;
   final List listCoin;

  @override
  State<TopGainers> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TopGainers> {
  @override
  Widget build(BuildContext context) {
    return widget.topGainers.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.topGainers.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              return CoinItem(
                listCoin:widget.listCoin,
                idUser: widget.idUser,
                id: widget.topGainers[index].id,
                name: widget.topGainers[index].name,
                symbol: widget.topGainers[index].symbol,
                image: widget.topGainers[index].image,
                price: widget.topGainers[index].price,
                priceChange: widget.topGainers[index].priceChange,
                changePercentage: widget.topGainers[index].changePercentage,
                marketCapRank: widget.topGainers[index].marketCapRank,
                marketCap: widget.topGainers[index].marketCap,
                fullyMarketCap: widget.topGainers[index].fullyMarketCap,
                totalVolume: widget.topGainers[index].totalVolume,
                high24h: widget.topGainers[index].high24h,
                low24h: widget.topGainers[index].low24h,
                supply: widget.topGainers[index].supply,
                maxSupply: widget.topGainers[index].maxSupply,
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
