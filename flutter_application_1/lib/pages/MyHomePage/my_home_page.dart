import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Home/home.dart';
import 'package:flutter_application_1/pages/Calculate/calculate.dart';
import 'package:flutter_application_1/pages/Portfolio/check_user_portfolio.dart';
import 'package:flutter_application_1/pages/AppBar/Actions/Search/search.dart';
import 'package:flutter_application_1/pages/AppBar/Leading/icon_button.dart';
import 'package:flutter_application_1/pages/Watchlist/check_user_watchlist.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.listCoin});
  final List listCoin;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String idUser = "64632aed164b2a0baf0f2bef";
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff151515),
          leading: Builder(
            builder: (BuildContext context) {
              return const Leading();
            },
          ),
          actions: <Widget>[Search(listCoin: widget.listCoin, idUser: idUser)],
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                // <-- SEE HERE
                decoration: BoxDecoration(color: Color(0xff151515)),
                accountName: Text(
                  "Chí Phèo",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  "abc@gmail.com",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: FlutterLogo(),
              ),
              ListTile(
                leading: const Icon(
                  Icons.verified_user,
                ),
                title: const Text('Page 1'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: bodyWidget(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: const IconThemeData(
            size: 28,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 24,
          ),
          backgroundColor: const Color(0xff151515),
          selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: const Color.fromARGB(255, 152, 152, 152),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.calculate), label: "Calculate"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.turned_in_not), label: "Watchlist"),
            BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart), label: "Portfolio"),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  bodyWidget(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return Calculate(listCoin: widget.listCoin);
      case 1:
        return Home(
          listCoin: widget.listCoin,
          idUser: idUser,
        );
      case 2:
        return CheckUserWatchlist(listCoin: widget.listCoin, idUser: idUser);
      case 3:
        return CheckUserPortfolio(listCoin: widget.listCoin, idUser: idUser);
    }
  }
}
