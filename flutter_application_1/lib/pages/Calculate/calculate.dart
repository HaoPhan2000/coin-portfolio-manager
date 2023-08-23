import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/model/coin_card_model.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Calculate extends StatefulWidget {
  const Calculate({super.key, required this.listCoin});
  final List listCoin;
  @override
  State<Calculate> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Calculate> {
  final TextEditingController _controllerPurchasePrice =
      TextEditingController();
  final TextEditingController _controllerTotal = TextEditingController();
  String hintText = "coin search";
  String selectedCoin = "";
  String purchasePrice = "";
  String total = "";
  num pnl = 0;
  num roe = 0;
  bool isButtonEnabled = false;
  bool isDoubleDotPurchasePrice = false;
  bool isDoubleDotTotal = false;

  var color = const Color.fromARGB(255, 255, 255, 255);
  List<CoinCard> coin = [];
  @override
  void initState() {
    super.initState();
    //datafromAPI lúc này trả về list dynamic thì lấy ra mà quẩy
    setState(() {
      var data = widget.listCoin;
      coin = data.map((e) => CoinCard.fromJson(e)).toList();
    });
  }

  void checkInputValue() {
    if (selectedCoin.trim().isNotEmpty &&
        purchasePrice.isNotEmpty &&
        total.isNotEmpty &&
        num.parse(purchasePrice) > 0 &&
        num.parse(total) > 0) {
      isButtonEnabled = true;
      setState(() {});
    } else {
      isButtonEnabled = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controllerPurchasePrice.dispose();
    _controllerTotal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xff151515),
              title: const Text(
                'Confirm',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 18,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              content: const Text('Do you want to exit the app?',
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
                            backgroundColor: MaterialStateProperty.all<Color>(
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
                        onPressed: () {
                          SystemChannels.platform.invokeMethod<void>(
                              'SystemNavigator.pop'); // Thoát khỏi ứng dụng
                        },
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
                            backgroundColor: MaterialStateProperty.all<Color>(
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
                        onPressed: () {
                          Navigator.pop(context); // Đóng hộp thoại xác nhận
                        },
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
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Coin",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18,
                          color: Color.fromARGB(255, 215, 215, 215),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 240, 240, 240),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TypeAheadField<CoinCard?>(
                          hideSuggestionsOnKeyboardHide: false,
                          textFieldConfiguration: TextFieldConfiguration(
                            cursorColor: const Color.fromRGBO(255, 204, 0, 1),
                            decoration: InputDecoration(
                              prefixIconColor: const Color(0xff151515),
                              focusedBorder: InputBorder.none,
                              prefixIcon: const Icon(Icons.arrow_drop_down),
                              hintText: hintText,
                              hintStyle: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 16,
                                color: Color(0xff151515),
                              ),
                            ),
                          ),
                          suggestionsCallback: (String query) {
                            return List.of(coin).where((coin) {
                              final userLower = coin.name.toLowerCase();
                              final queryLower = query.toLowerCase();

                              return userLower.contains(queryLower);
                            }).toList();
                          },
                          itemBuilder: (context, CoinCard? suggestion) {
                            final coin = suggestion!;

                            return ListTile(
                              leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.network(
                                    coin.image,
                                    fit: BoxFit.cover,
                                  )),
                              title: Text(
                                coin.name,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                  color: Color(0xff151515),
                                ),
                              ),
                            );
                          },
                          noItemsFoundBuilder: (context) => const SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                'Không tìm thấy',
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 20,
                                  color: Color(0xff151515),
                                ),
                              ),
                            ),
                          ),
                          onSuggestionSelected: (CoinCard? suggestion) {
                            final coin = suggestion!;
                            setState(() {
                              hintText = coin.name;
                            });
                            selectedCoin = coin.price.toString();
                            checkInputValue();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 65),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Giá mua vào",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18,
                          color: Color.fromARGB(255, 215, 215, 215),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 240, 240, 240),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  onChanged: (value) {
                                    String updatedValue = value
                                        .replaceAll('-', '')
                                        .replaceAll(' ', '')
                                        .replaceAll(',', '');
                                    purchasePrice = updatedValue;
                                    int dotIndex = updatedValue.indexOf('.');

                                    isDoubleDotPurchasePrice = dotIndex != -1 &&
                                        dotIndex !=
                                            updatedValue.lastIndexOf('.');
                                    if (value != updatedValue) {
                                      _controllerPurchasePrice.value =
                                          _controllerPurchasePrice.value
                                              .copyWith(
                                        text: updatedValue,
                                        selection: TextSelection.collapsed(
                                            offset: updatedValue.length),
                                      );
                                      purchasePrice = updatedValue;
                                    }
                                    if (isDoubleDotPurchasePrice) {
                                      String newText = updatedValue.substring(
                                              0, dotIndex + 1) +
                                          updatedValue
                                              .substring(dotIndex + 1)
                                              .replaceAll('.', '');
                                      _controllerPurchasePrice.value =
                                          _controllerPurchasePrice.value
                                              .copyWith(
                                                  text: newText,
                                                  selection:
                                                      TextSelection.collapsed(
                                                          offset:
                                                              newText.length));
                                      purchasePrice = newText;
                                    }
                                    checkInputValue();
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: _controllerPurchasePrice,
                                  cursorColor:
                                      const Color.fromRGBO(255, 204, 0, 1),
                                  decoration: const InputDecoration(
                                    prefixIconColor: Color(0xff151515),
                                    focusedBorder: InputBorder.none,
                                    hintText: "0.00",
                                    hintStyle: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 16,
                                      color: Color(0xff151515),
                                    ),
                                  ),
                                ),
                              )),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "USDT",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    color: Color(0xff151515),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(height: 65),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Số tiền",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18,
                          color: Color.fromARGB(255, 215, 215, 215),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 240, 240, 240),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  onChanged: (value) {
                                    String updatedValue = value
                                        .replaceAll('-', '')
                                        .replaceAll(' ', '')
                                        .replaceAll(',', '');
                                    total = updatedValue;
                                    int dotIndex = updatedValue.indexOf('.');

                                    isDoubleDotTotal = dotIndex != -1 &&
                                        dotIndex !=
                                            updatedValue.lastIndexOf('.');
                                    if (value != updatedValue) {
                                      _controllerTotal.value =
                                          _controllerTotal.value.copyWith(
                                        text: updatedValue,
                                        selection: TextSelection.collapsed(
                                            offset: updatedValue.length),
                                      );
                                      total = updatedValue;
                                    }
                                    if (isDoubleDotTotal) {
                                      String newText = updatedValue.substring(
                                              0, dotIndex + 1) +
                                          updatedValue
                                              .substring(dotIndex + 1)
                                              .replaceAll('.', '');
                                      _controllerTotal.value =
                                          _controllerTotal.value.copyWith(
                                              text: newText,
                                              selection:
                                                  TextSelection.collapsed(
                                                      offset: newText.length));
                                      total = newText;
                                    }
                                    checkInputValue();
                                  },
                                  controller: _controllerTotal,
                                  keyboardType: TextInputType.number,
                                  cursorColor:
                                      const Color.fromRGBO(255, 204, 0, 1),
                                  decoration: const InputDecoration(
                                    prefixIconColor: Color(0xff151515),
                                    focusedBorder: InputBorder.none,
                                    hintText: "0.00",
                                    hintStyle: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 16,
                                      color: Color(0xff151515),
                                    ),
                                  ),
                                ),
                              )),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "USDT",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    color: Color(0xff151515),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Kết quả",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Giá hiện tại",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16,
                              color: Color.fromARGB(255, 215, 215, 215),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "PNL",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16,
                              color: Color.fromARGB(255, 215, 215, 215),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "ROE",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16,
                              color: Color.fromARGB(255, 215, 215, 215),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  selectedCoin,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                "USDT",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  pnl.toStringAsFixed(0).toString(),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    color: color,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "USDT",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  color: color,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  roe.toStringAsFixed(0).toString(),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    color: color,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "%",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  color: color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () {
                              num numSelectedCoin = num.parse(selectedCoin);
                              num numpurchasePrice = num.parse(purchasePrice);
                              num numtotal = num.parse(total);

                              num soLuong = numtotal / numpurchasePrice;
                              pnl = soLuong * numSelectedCoin;

                              roe = (pnl - numtotal) / numtotal * 100;
                              if (roe == 0) {
                                color =
                                    const Color.fromARGB(255, 255, 255, 255);
                              } else {
                                if (roe > 0) {
                                  color = const Color(0xff42be65);
                                } else {
                                  color = const Color(0xfffa4d56);
                                }
                              }
                              setState(() {});
                            }
                          : null,
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 1, 50)),
                        backgroundColor: isButtonEnabled == true
                            ? MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(255, 204, 0, 1),
                              )
                            : MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 152, 152, 152),
                              ),
                        shape: isButtonEnabled == true
                            ? MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(255, 204, 0, 1),
                                  ),
                                ),
                              )
                            : MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 152, 152, 152),
                                  ),
                                ),
                              ),
                      ),
                      child: const Text(
                        'Tính toán',
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18,
                          color: Color(0xff151515),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
