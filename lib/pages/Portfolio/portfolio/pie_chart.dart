import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/pie_chart_model.dart';
import 'package:flutter_application_1/network/request_get_portfolio.dart';
import 'package:flutter_application_1/pages/Link_Page/loading_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatelessWidget {
  final String idUser;
  final List<dynamic> listCoin;

  const PieChart({super.key, required this.idUser, required this.listCoin});

  Future<List<PieChartModel>> getDataPortfolio() async {
    List<PieChartModel> portfolioList = [];

    NetworkRequestGetCoin networkRequestGetCoin =
        NetworkRequestGetCoin(idUser: idUser);

    List<dynamic> dataFromAPI = await networkRequestGetCoin.fetchPosts();

    for (var dataFromAPIElement in dataFromAPI) {
      for (var listCoinElement in listCoin) {
        if (listCoinElement["id"] == dataFromAPIElement["id"]) {
          num quantityBuy = 0;
          num quantitySell = 0;

          for (var transactionElement in dataFromAPIElement["transactions"]) {
            if (transactionElement["type"] == "Mua") {
              quantityBuy += num.parse(transactionElement["total"]) /
                  num.parse(transactionElement["price"]);
            }
          }

          for (var transactionElement in dataFromAPIElement["transactions"]) {
            if (transactionElement["type"] == "Ban") {
              quantitySell += num.parse(transactionElement["total"]) /
                  num.parse(transactionElement["price"]);
            }
          }

          portfolioList.add(PieChartModel(
            name: listCoinElement["name"],
            total: num.parse((listCoinElement["current_price"] *
                    (quantityBuy - quantitySell))
                .toStringAsFixed(2)),
          ));

          break;
        }
      }
    }

    return portfolioList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PieChartModel>>(
      future: getDataPortfolio(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Đang lấy dữ liệu từ API
          return const SizedBox(
              height: 300,
              child: Center(child: LoadingPage())); // Hiển thị màn hình chờ
        } else {
          List<PieChartModel> portfolioData = snapshot.data!;
          if (portfolioData.isNotEmpty) {
            return SfCircularChart(
              legend: Legend(
                textStyle: const TextStyle(color: Colors.white),
                position: LegendPosition.bottom,
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              series: <CircularSeries>[
                PieSeries<PieChartModel, String>(
                  dataSource: portfolioData,
                  xValueMapper: (PieChartModel data, _) => data.name,
                  yValueMapper: (PieChartModel data, _) => data.total,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            );
          } else {
            return const SizedBox(
                height: 300,
                child: Center(
                    child: Text(
                  "Không có tài sản nào",
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
