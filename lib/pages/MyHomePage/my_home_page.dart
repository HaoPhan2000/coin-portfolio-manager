import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_page_sign_up_page/login_page.dart';
import 'package:flutter_application_1/pages/Home/home.dart';
import 'package:flutter_application_1/pages/Calculate/calculate.dart';
import 'package:flutter_application_1/pages/Portfolio/check_user_portfolio.dart';
import 'package:flutter_application_1/pages/AppBar/Actions/Search/search.dart';
import 'package:flutter_application_1/pages/AppBar/Leading/icon_button.dart';
import 'package:flutter_application_1/pages/Watchlist/check_user_watchlist.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.listCoin, String? idUser})
      : idUser = idUser ?? "";
  final List listCoin;
  final String idUser;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  String idUser = "";
  @override
  void initState() {
    super.initState();
    idUser = widget.idUser;
  }

  void notificationsuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text(
            'Sign out success',
            style: TextStyle(color: Color(0xff151515)),
          ),
        ),
        backgroundColor: Color.fromRGBO(255, 204, 0, 1),
      ),
    );
  }

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
          child: Container(
            color: const Color(0xff151515),
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  // <-- SEE HERE
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 50, 50, 50)),
                  accountName: idUser.isNotEmpty
                      ? const Text(
                          "Chí Phèo",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(""),
                  accountEmail: idUser.isNotEmpty
                      ? const Text(
                          "abc@gmail.com",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(""),
                  currentAccountPicture:Image.asset("assets/images/logo.png")
                ),
                idUser.isEmpty
                    ? ListTile(
                        leading: const Icon(
                          Icons.login_outlined,
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 20,
                        ),
                        title: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(listCoin: widget.listCoin)));
                        },
                      )
                    : Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.supervised_user_circle,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 20,
                            ),
                            title: const Text(
                              'Tài khoản',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.logout_sharp,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 20,
                            ),
                            title: const Text(
                              'Đăng xuất',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                idUser = "";
                                notificationsuccess();
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 50,
                ),
                const ListTile(
                  title: Center(
                      child: Column(
                    children: [
                      Text(
                        "using Data by CoinGecko",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "EHPHAS Portfolio",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "1.1.1.1",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )),
                ),
              ],
            ),
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
