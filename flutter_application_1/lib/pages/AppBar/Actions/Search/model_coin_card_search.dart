import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/coin_card_model.dart';
import 'package:flutter_application_1/pages/AppBar/Actions/Search/coin_card_search.dart';

class ModelCoinCardSearch extends StatefulWidget {
  const ModelCoinCardSearch(
      {Key? key,
      required this.coinCards,
      required this.idUser,
      required this.listCoin
   })
      : super(key: key);
  final List<CoinCard> coinCards;
  final String idUser;
    final List listCoin;
 
  @override
  State<ModelCoinCardSearch> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ModelCoinCardSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(50, 50, 50, 1),
      child: widget.coinCards.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.coinCards.length,
              itemBuilder: (context, index) {
                return SearchCoinItem(
                listCoin:widget.listCoin,
                  idUser: widget.idUser,
                  id: widget.coinCards[index].id,
                  name: widget.coinCards[index].name,
                  symbol: widget.coinCards[index].symbol,
                  image: widget.coinCards[index].image,
                  price: widget.coinCards[index].price,
                  priceChange: widget.coinCards[index].priceChange,
                  changePercentage: widget.coinCards[index].changePercentage,
                  marketCapRank: widget.coinCards[index].marketCapRank,
                  marketCap: widget.coinCards[index].marketCap,
                  fullyMarketCap: widget.coinCards[index].fullyMarketCap,
                  totalVolume: widget.coinCards[index].totalVolume,
                  high24h: widget.coinCards[index].high24h,
                  low24h: widget.coinCards[index].low24h,
                  supply: widget.coinCards[index].supply,
                  maxSupply: widget.coinCards[index].maxSupply,
                );
              },
            )
          : const Center(
              child: Text(
                "Không tìm thấy!",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
