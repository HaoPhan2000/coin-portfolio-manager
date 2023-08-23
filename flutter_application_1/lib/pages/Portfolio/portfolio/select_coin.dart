import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/coin_card_model.dart';
import 'package:flutter_application_1/pages/Portfolio/portfolio/add_transaction_and_add_coin.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

class SelectCoin extends StatefulWidget {
  const SelectCoin({super.key, required this.listCoin, required this.idUser});
  final List listCoin;
  final String idUser;
  @override
  State<SelectCoin> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SelectCoin> {
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

  void screenswitch() {
    Navigator.pop(context, 'resetWhatList');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, 'resetPortlio');
            },
          ),
          backgroundColor: const Color(0xff151515),
          title: const Text(
            "Thêm giao dịch",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 18,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TypeAheadField<CoinCard?>(
            hideSuggestionsOnKeyboardHide: false,
            textFieldConfiguration: const TextFieldConfiguration(
              autofocus: true,
              cursorColor: Color.fromRGBO(255, 204, 0, 1),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(108, 140, 145, 175),
                prefixIconColor: Color(0xff151515),
                focusedBorder: InputBorder.none,
                prefixIcon: Icon(Icons.arrow_drop_down),
                hintText: "Select Coin",
                hintStyle: TextStyle(
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

              return Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(108, 140, 145, 175),
                  border: Border(
                    bottom: BorderSide(
                      color:
                          Color.fromARGB(255, 180, 180, 180), // Màu của border
                      width: 0.5, // Độ dày của border
                    ),
                  ),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.network(
                        coin.image,
                        fit: BoxFit.cover,
                      )),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        coin.name,
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18,
                          color: Color(0xff151515),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Color(0xff151515),
                      )
                    ],
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
            onSuggestionSelected: (CoinCard? suggestion) async {
              final coin = suggestion!;
              final result = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddTransactionAndCoin(
                        idUser: widget.idUser,
                        idCoin: coin.id,
                        nameCoin: coin.name,
                        symbol: coin.symbol,
                        image: coin.image,
                      )));
              if (result != null) {
                screenswitch();
              }
            },
          ),
        ),
      ),
    );
  }
}
