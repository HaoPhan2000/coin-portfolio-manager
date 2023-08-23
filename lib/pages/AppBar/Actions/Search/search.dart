import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/coin_card_model.dart';
import 'package:flutter_application_1/pages/AppBar/Actions/Search/model_coin_card_search.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.listCoin, required this.idUser, });
  final List listCoin;
  final String idUser;
   

  @override
  State<Search> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Search> {
  List<CoinCard> storage = [];
  List<CoinCard> coinCards = [];
  List<dynamic> listCoinFromAPI = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      listCoinFromAPI = widget.listCoin;
      storage = widget.listCoin.map((e) => CoinCard.fromJson(e)).toList();
      coinCards = widget.listCoin.map((e) => CoinCard.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: IconButton(
        padding: const EdgeInsets.all(10),
        icon: const Icon(Icons.search),
        iconSize: 30,
        color: const Color.fromARGB(255, 255, 255, 255),
        onPressed: () {
          coinCards = storage;
          showModalBottomSheet(
              backgroundColor: const Color.fromRGBO(50, 50, 50, 1),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(152, 152, 152, 0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          cursorColor: const Color.fromARGB(255, 255, 255, 255),
                          onChanged: (text) {
                            var dataTam = listCoinFromAPI
                                .where((list) => list["name"]
                                    .toLowerCase()
                                    .startsWith(text.toLowerCase()))
                                .toList();
                        
                            setState(() {
                              coinCards = dataTam
                                  .map((e) => CoinCard.fromJson(e))
                                  .toList();
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              labelText: "Coin finden",
                              labelStyle: const TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: ModelCoinCardSearch(
                            listCoin:widget.listCoin,
                            coinCards: coinCards,
                            idUser: widget.idUser,
                          ))
                    ]),
                  ),
                );
              });
        },
      ),
    );
  }
}
