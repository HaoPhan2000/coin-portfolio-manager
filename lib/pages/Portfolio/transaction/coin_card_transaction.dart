import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Portfolio/transaction/update_transaction.dart';

class CoinCardTransaction extends StatefulWidget {
  const CoinCardTransaction({super.key,required this.id,
    required this.price,
    required this.soTien,
    required this.soLuong,
    required this.time,
    required this.type,
    required this.symbol,
    required this.name,
    required this.image,
    required this.getDataTransaction});
     final String id;
  final num price;
  final num soTien;
  final num soLuong;
  final String time;
  final String type;
  final String name;
  final String symbol;
  final String image;
   final Function() getDataTransaction;

  @override
  State<CoinCardTransaction> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CoinCardTransaction> {
  void closeBottomSheet(){
   Navigator.pop(context);
}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 70,
        padding: const EdgeInsets.only(top: 20, bottom: 10, right: 10),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Color.fromARGB(108, 210, 220, 255), width: 1))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(108, 210, 220, 255),
                      ),
                      width: 30,
                      height: 30,
                      child: Icon(
                       widget.type == "Mua"
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        size: 22,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.type,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.time,
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 180, 180, 180),
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Row(
                  children: [
                    Flexible(
                        child: Text(
                      widget.price.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    )),
                    const SizedBox(
                      width: 3,
                    ),
                    const Text(
                      "\$",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        widget.soTien.toString(),
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      )),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text(
                        "\$",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          widget.type == "Mua"
                              ? "+ ${widget.soLuong.toStringAsFixed(4)}"
                              : "- ${widget.soLuong.toStringAsFixed(4)}",
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: widget.type == "Mua"
                                ? const Color(0xff42be65)
                                : const Color(0xfffa4d56),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(widget.symbol,
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 180, 180, 180),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                  color: const Color(0xff151515),
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(Size(
                                    MediaQuery.of(context).size.width * 1, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(255, 204, 0, 1),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Color.fromRGBO(255, 204, 0, 1),
                                    ),
                                  ),
                                )),
                            onPressed: ()async {
                                 final result = await Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => UpDateTransaction(
                                          idTransaction:widget.id,
                                          nameCoin:widget.name,
                                          symbol:widget.symbol,
                                          image:widget.image,
                                          price: widget.price,
                                          soTien: widget.soTien,
                                          type: widget.type,
                                          time: widget.time,
                                        )));
                                          if (result != null) {
                              widget.getDataTransaction();
                              closeBottomSheet();
                            
                            }
                            },
                            child: const Text(
                              "Sửa giao dịch",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  color: Color(0xff151515)),
                            )),
                      ),
                    ),
                  ));
            });
      },
    );
  }
}



