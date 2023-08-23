import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Home/coin_detail.dart';

class SearchCoinItem extends StatelessWidget {
  const SearchCoinItem({
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
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              SizedBox(
                width: 18,
                height: 18,
                child: Image.network(image.toString()),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    name,
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
              ),
              Expanded(
                child: Text(
                  symbol.toUpperCase(),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CoinDetail(
                  listCoin:listCoin,
                  idUser: idUser,
                  id: id,
                  name: name,
                  symbol: symbol,
                  image: image,
                  price: price,
                  priceChange: priceChange,
                  changePercentage: changePercentage,
                  marketCapRank: marketCapRank,
                  marketCap: marketCap,
                  fullyMarketCap: fullyMarketCap,
                  totalVolume: totalVolume,
                  high24h: high24h,
                  low24h: low24h,
                  supply: supply,
                  maxSupply: maxSupply,
                )));
      },
    );
  }
}
