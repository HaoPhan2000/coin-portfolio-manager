import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/request_get_history_data_30day_coin.dart';
import 'package:flutter_application_1/pages/Link_Page/loading_page.dart';

class ChartWatchList extends StatefulWidget {
  const ChartWatchList({super.key, required this.id, required this.priceChange});
  final String id;
  final num priceChange;

  @override
  State<ChartWatchList> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ChartWatchList> {
  List<FlSpot> coin = [];
  double maxX = 0;
  double maxValue = 0;
  double minValue = 0;
  @override
  void initState() {
    super.initState();
    NetworkRequestHistoryData30Day networkRequestHistoryData30Day =
        NetworkRequestHistoryData30Day(id: widget.id);
    networkRequestHistoryData30Day.fetchPosts().then((datafromAPI) {
      setState(() {
        int lengthDataFromAPI = datafromAPI.length;
        for (int i = 0; i < lengthDataFromAPI; i++) {
          coin.add(FlSpot(i.toDouble(), datafromAPI[i]));
        }
        maxX = coin.length.toDouble();
        maxValue = datafromAPI
            .reduce((value, element) => value > element ? value : element);
        minValue = datafromAPI
            .reduce((value, element) => value < element ? value : element);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return coin.isNotEmpty
        ? SizedBox(
            height: 250,
            width: double.infinity,
            child: LineChart(LineChartData(
                minX: 0,
                maxX: maxX,
                minY: minValue,
                maxY: maxValue,
                titlesData: FlTitlesData(show: false),
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                        color: const Color.fromRGBO(115, 115, 115, 0.8),
                        strokeWidth: 0.1);
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                        color: const Color.fromRGBO(115, 115, 115, 0.8),
                        strokeWidth: 0.1);
                  },
                ),
                lineBarsData: [
                  LineChartBarData(
                      spots: coin,
                      color: widget.priceChange >= 0
                          ? const Color(0xff42be65)
                          : const Color(0xfffa4d56),
                      isCurved: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: widget.priceChange >= 0
                            ? const Color(0xff42be65).withOpacity(0.1)
                            : const Color(0xfffa4d56).withOpacity(0.1),
                      ))
                ])),
          )
        : const SizedBox(height: 250, child: Center(child: LoadingPage()));
  }
}
