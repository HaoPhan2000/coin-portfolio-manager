import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/transaction_model.dart';
import 'package:flutter_application_1/network/request_delete_transaction.dart';
import 'package:flutter_application_1/pages/Portfolio/transaction/coin_card_transaction.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListViewTransaction extends StatefulWidget {
  const ListViewTransaction(
      {Key? key,
      required this.symbol,
      required this.listTransactionModel,
      required this.getDataCoin,
      required this.getDataTransaction})
      : super(key: key);
  final String symbol;
  final List<TransactionModel> listTransactionModel;
  final Function() getDataTransaction;
  final Function() getDataCoin;

  @override
  State<ListViewTransaction> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListViewTransaction> {
  Future deleteTransaction(idTransaction) async {
    NetworkRequestDeleteTransaction networkRequestDeleteTransaction =
        NetworkRequestDeleteTransaction(idTransaction: idTransaction);
    await networkRequestDeleteTransaction.fetchPosts();
    Fluttertoast.showToast(
        msg: 'Xóa thành công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color(0xfff0f0f0),
        textColor: const Color.fromARGB(255, 0, 0, 0),
        fontSize: 16.0);

    widget.getDataCoin();
    widget.getDataTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.listTransactionModel.length,
      itemBuilder: (context, index) {
        return Dismissible(
            movementDuration: const Duration(milliseconds: 500),
            key: Key(widget.listTransactionModel.length.toString()),
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
              deleteTransaction(widget.listTransactionModel[index].id);
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
            child: CoinCardTransaction(
              id: widget.listTransactionModel[index].id,
              price: widget.listTransactionModel[index].price,
              soTien: widget.listTransactionModel[index].total,
              soLuong: widget.listTransactionModel[index].quantity,
              time: widget.listTransactionModel[index].time,
              type: widget.listTransactionModel[index].type,
              symbol: widget.symbol,
            ));
      },
    );
  }
}
