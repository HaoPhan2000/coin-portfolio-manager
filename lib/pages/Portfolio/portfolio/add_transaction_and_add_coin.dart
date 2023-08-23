import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/request_add_coin.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTransactionAndCoin extends StatefulWidget {
  const AddTransactionAndCoin(
      {super.key,
      required this.idUser,
      required this.idCoin,
      required this.nameCoin,
      required this.price,
      required this.symbol,
      required this.image});
  final String idUser;
  final String idCoin;
  final String nameCoin;
  final num price;
  final String symbol;
  final String image;

  @override
  State<AddTransactionAndCoin> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddTransactionAndCoin> {
  final TextEditingController _controllerPurchasePrice =
      TextEditingController();
  final TextEditingController _controllerTotal = TextEditingController();
  DateTime dateTime = DateTime.now();
  final List<bool> selections = [true, false];

  bool isButtonEnabled = false;

  bool isDoubleDotPurchasePrice = false;
  bool isDoubleDotTotal = false;

  String selectionType = "Mua";
  String selectionDateTime = "";
  String purchasePrice = "";
  String total = "";
  Map coin = {};
  @override
  void initState() {
    super.initState();
    selectionDateTime =
        "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
    _controllerPurchasePrice.text=widget.price.toString();
    purchasePrice=widget.price.toString();
  }

  Future addTransactionAndCoin() async {
    coin = {
      "id": widget.idCoin,
      "name": widget.nameCoin,
      "user": widget.idUser,
      "price": purchasePrice,
      "total": total,
      "type": selectionType,
      "time": selectionDateTime
    };
    NetworkRequestAddCoin networkRequestAddWatchList =
        NetworkRequestAddCoin(jsonBody: coin);
    await networkRequestAddWatchList.fetchPosts();
    Fluttertoast.showToast(
        msg: 'Thêm coin thành công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color(0xfff0f0f0),
        textColor: const Color.fromARGB(255, 0, 0, 0),
        fontSize: 16.0);
    screenswitch();
  }
void screenswitch() {
    Navigator.pop(context, 'reset');
  }
  void checkInputValue() {
    if (widget.idUser.isNotEmpty == true &&
        widget.idCoin.isNotEmpty == true &&
        widget.nameCoin.isNotEmpty == true &&
        selectionType.isNotEmpty == true &&
        selectionDateTime.isNotEmpty == true &&
        purchasePrice.isNotEmpty == true &&
        total.isNotEmpty == true) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
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
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
              Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff151515),
        title: Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Image.network(
                widget.image,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              widget.nameCoin,
              style: const TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              widget.symbol.toUpperCase(),
              style: const TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color.fromARGB(255, 180, 180, 180),
              ),
            )
          ],
        ),
      ),
      body: Container(
        color: const Color(0xff151515),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < selections.length; i++) {
                    selections[i] = i == index;
                  }
                });
                index == 0 ? selectionType = "Mua" : selectionType = "Ban";
              },
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              fillColor: const Color.fromARGB(108, 140, 145, 175),
              selectedColor: const Color.fromARGB(255, 255, 255, 255),
              color: const Color.fromARGB(255, 255, 255, 255),
              splashColor: const Color.fromARGB(108, 170, 170, 200),
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.47,
                minHeight: 40,
                maxHeight: double.infinity,
              ),
              isSelected: selections,
              children: const <Widget>[
                Text(
                  'Mua',
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Bán',
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set your desired border radius value
                  ),
                  backgroundColor: const Color.fromARGB(108, 140, 145, 175),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: CupertinoDatePicker(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            initialDateTime: dateTime,
                            onDateTimeChanged: (DateTime newTime) {
                              setState(() {
                                dateTime = newTime;
                                selectionDateTime =
                                    "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
                              });
                            },
                            mode: CupertinoDatePickerMode.dateAndTime,
                            use24hFormat: true,
                          ),
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')} giờ : ${dateTime.minute.toString().padLeft(2, '0')} phút",
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      )
                    ],
                  ),
                )),
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Giá đồng coin",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 18,
                    color: Color.fromARGB(255, 180, 180, 180),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(108, 140, 145, 175),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            onChanged: (value) {
                              String updatedValue = value
                                  .replaceAll('-', '')
                                  .replaceAll(' ', '')
                                  .replaceAll(',', '');
                              purchasePrice = updatedValue;
                              int dotIndex = updatedValue.indexOf('.');

                              isDoubleDotPurchasePrice = dotIndex != -1 &&
                                  dotIndex != updatedValue.lastIndexOf('.');
                              if (value != updatedValue) {
                                _controllerPurchasePrice.value =
                                    _controllerPurchasePrice.value.copyWith(
                                  text: updatedValue,
                                  selection: TextSelection.collapsed(
                                      offset: updatedValue.length),
                                );
                                purchasePrice = updatedValue;
                              }
                              if (isDoubleDotPurchasePrice) {
                                String newText =
                                    updatedValue.substring(0, dotIndex + 1) +
                                        updatedValue
                                            .substring(dotIndex + 1)
                                            .replaceAll('.', '');
                                _controllerPurchasePrice.value =
                                    _controllerPurchasePrice.value.copyWith(
                                        text: newText,
                                        selection: TextSelection.collapsed(
                                            offset: newText.length));
                                purchasePrice = newText;
                              }
                              checkInputValue();
                            },
                            keyboardType: TextInputType.number,
                            controller: _controllerPurchasePrice,
                            cursorColor: const Color.fromRGBO(255, 204, 0, 1),
                            decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              hintText: "0.00",
                              hintStyle: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 255, 255),
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
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Số tiền",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 18,
                    color: Color.fromARGB(255, 180, 180, 180),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(108, 140, 145, 175),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            onChanged: (value) {
                              String updatedValue = value
                                  .replaceAll('-', '')
                                  .replaceAll(' ', '')
                                  .replaceAll(',', '');
                              total = updatedValue;
                              int dotIndex = updatedValue.indexOf('.');

                              isDoubleDotTotal = dotIndex != -1 &&
                                  dotIndex != updatedValue.lastIndexOf('.');
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
                                String newText =
                                    updatedValue.substring(0, dotIndex + 1) +
                                        updatedValue
                                            .substring(dotIndex + 1)
                                            .replaceAll('.', '');
                                _controllerTotal.value = _controllerTotal.value
                                    .copyWith(
                                        text: newText,
                                        selection: TextSelection.collapsed(
                                            offset: newText.length));
                                total = newText;
                              }
                              checkInputValue();
                            },
                            keyboardType: TextInputType.number,
                            controller: _controllerTotal,
                            cursorColor: const Color.fromRGBO(255, 204, 0, 1),
                            decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              hintText: "0.00",
                              hintStyle: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 255, 255),
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
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          addTransactionAndCoin();
                        }
                      : null,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width * 1, 50)),
                    backgroundColor: isButtonEnabled
                        ? MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(255, 204, 0, 1),
                          )
                        : MaterialStateProperty.all<Color>(
                            const Color.fromARGB(108, 140, 145, 175),
                          ),
                    shape: isButtonEnabled
                        ? MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Color.fromRGBO(255, 204, 0, 1),
                              ),
                            ),
                          )
                        : MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Color.fromARGB(108, 140, 145, 175),
                              ),
                            ),
                          ),
                  ),
                  child: const Text(
                    'Thêm giao dịch',
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 18,
                        color: Color(0xff151515)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
