import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/portfolio_model.dart';
import 'package:flutter_application_1/network/request_delete_coin.dart';
import 'package:flutter_application_1/pages/Portfolio/portfolio/coin_card_portfolio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListViewPortfolio extends StatefulWidget {
  const ListViewPortfolio(
      {Key? key,
      required this.listPortfolioModel,
      required this.isPercent,
      required this.totalValuePortfolio,
      required this.callback,
      required this.listCoin,
      required this.idUser})
      : super(key: key);
  final List<PortfolioModel> listPortfolioModel;
  final int isPercent;
  final num totalValuePortfolio;
  final Function() callback;
  final List listCoin;
  final String idUser;

  @override
  State<ListViewPortfolio> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListViewPortfolio> {
  Future deleteCoin(idCoinFromDB) async {
    NetworkRequestDeleteCoin networkRequestDeleteCoin =
        NetworkRequestDeleteCoin(idCoinFromDB: idCoinFromDB);
    await networkRequestDeleteCoin.fetchPosts();
    Fluttertoast.showToast(
        msg: 'Xóa thành công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color(0xfff0f0f0),
        textColor: const Color.fromARGB(255, 0, 0, 0),
        fontSize: 16.0);
    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.listPortfolioModel.length,
      itemBuilder: (context, index) {
        return Dismissible(
            movementDuration: const Duration(milliseconds: 500),
            key: Key(widget.listPortfolioModel.length.toString()),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              // Hiển thị hộp thoại xác nhận trước khi xóa
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xff151515),
                    title: const Text(
                      'Xác nhận',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 18,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    content:
                        const Text('Bạn có chắc chắn muốn xóa tài sản này?',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 18,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(255, 204, 0, 1),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: const BorderSide(
                                        color: Color.fromRGBO(255, 204, 0, 1),
                                      ),
                                    ),
                                  )),
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  color: Color(0xff151515),
                                ),
                              )),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(255, 204, 0, 1),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: const BorderSide(
                                        color: Color.fromRGBO(255, 204, 0, 1),
                                      ),
                                    ),
                                  )),
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text(
                                "No",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  color: Color(0xff151515),
                                ),
                              )),
                        ],
                      )
                    ],
                  );
                },
              );
            },
            onDismissed: (direction) {
              deleteCoin(widget.listPortfolioModel[index].idCoinFromDB);
            },
            background: Container(
              color: Colors.red,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20),
                  Text('Vuốt để xóa', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 10),
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(width: 20),
                ],
              ),
            ),
            child: CoinItemPortfolio(
              idCoinFromDB: widget.listPortfolioModel[index].idCoinFromDB,
              id: widget.listPortfolioModel[index].id,
              name: widget.listPortfolioModel[index].name,
              symbol: widget.listPortfolioModel[index].symbol,
              image: widget.listPortfolioModel[index].image,
              price: widget.listPortfolioModel[index].price,
              priceChange: widget.listPortfolioModel[index].priceChange,
              soLuongConLai: widget.listPortfolioModel[index].soLuongConLai,
              valueCoin: widget.listPortfolioModel[index].valueCoin,
              isPercent: widget.isPercent,
              totalValuePortfolio: widget.totalValuePortfolio,
              listCoin: widget.listCoin,
              idUser: widget.idUser,
              percent: widget.listPortfolioModel[index].valueCoin/widget.totalValuePortfolio*100,
              callback: widget.callback,
            ));
      },
    );
  }
}
