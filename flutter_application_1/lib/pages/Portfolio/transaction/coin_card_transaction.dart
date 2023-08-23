import 'package:flutter/material.dart';

class CoinCardTransaction extends StatelessWidget {
  const CoinCardTransaction({
    super.key,
    required this.id,
    required this.price,
    required this.soTien,
    required this.soLuong,
    required this.time,
    required this.type,
    required this.symbol,
  });

  final String id;
  final num price;
  final num soTien;
  final num soLuong;
  final String time;
  final String type;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      type == "Mua"
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
                          type,
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
                              time,
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
              padding: const EdgeInsets.only(left:3),
              child: Row(
                children: [
                  Flexible(
                      child: Text(
                    price.toString(),
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
                      soTien.toString(),
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
                        type == "Mua"
                            ? "+ ${soLuong.toStringAsFixed(4)}"
                            : "- ${soLuong.toStringAsFixed(4)}",
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: type == "Mua"
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
                      child: Text(symbol,
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
    );
  }
}
