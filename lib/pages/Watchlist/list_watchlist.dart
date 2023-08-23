import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/coin_card_model.dart';
import 'package:flutter_application_1/network/request_get_watchlist.dart';
import 'package:flutter_application_1/pages/Link_Page/loading_page.dart';
import 'package:flutter_application_1/pages/Watchlist/coin_card.dart';

class ListWatchlist extends StatefulWidget {
  const ListWatchlist(
      {super.key, required this.listCoin, required this.idUser});
  final List listCoin;
  final String idUser;
  @override
  State<ListWatchlist> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListWatchlist> {
  Future<dynamic> getDataWatchList() async {
    List<dynamic> watchlist = [];
    NetworkRequestWatchList networkRequestWatchList =
        NetworkRequestWatchList(idUser: widget.idUser);

    await networkRequestWatchList.fetchPosts().then((datafromAPI) {
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
      watchlist = watchlist.map((e) => CoinCard.fromJson(e)).toList();
    });
    return watchlist;
  }

  //chạy để hàm build chạy lại
  void updatewatchlist() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: getDataWatchList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Đang lấy dữ liệu từ API
          return const Expanded(
            child: Center(
              child: LoadingPage(),
            ),
          ); //Hiển thị màn hình chờ
        } else {
          List<dynamic> watchlist = snapshot.data!;
          if (watchlist.isNotEmpty) {
            return Expanded(
              child: SizedBox(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: watchlist.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return CoinItemWatchList(
                      callback: updatewatchlist,
                      listCoin: widget.listCoin,
                      idUser: widget.idUser,
                      id: watchlist[index].id,
                      name: watchlist[index].name,
                      symbol: watchlist[index].symbol,
                      image: watchlist[index].image,
                      price: watchlist[index].price,
                      priceChange: watchlist[index].priceChange,
                      changePercentage: watchlist[index].changePercentage,
                      marketCapRank: watchlist[index].marketCapRank,
                      marketCap: watchlist[index].marketCap,
                      fullyMarketCap: watchlist[index].fullyMarketCap,
                      totalVolume: watchlist[index].totalVolume,
                      high24h: watchlist[index].high24h,
                      low24h: watchlist[index].low24h,
                      supply: watchlist[index].supply,
                      maxSupply: watchlist[index].maxSupply,
                    );
                  },
                ),
              ),
            );
          } else {
            return const Expanded(
                child: Center(
                    child: Text(
              "Không có đồng coin nào trong danh sách theo dõi",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ))); //
          }
        }
      },
    );
  }
}
