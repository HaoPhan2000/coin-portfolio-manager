import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_page_sign_up_page/sign_up.dart';
import 'package:flutter_application_1/network/request_login.dart';
import 'package:flutter_application_1/pages/MyHomePage/my_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.listCoin});
  final List listCoin;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  String password = "";
  String email = "";
  Map dataUser = {};
  String idUser = "";

  void notificationFailed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text(
            'Sign in failed',
            style: TextStyle(color: Color(0xff151515)),
          ),
        ),
        backgroundColor: Color.fromRGBO(255, 204, 0, 1),
      ),
    );
  }

  void notificationsuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text(
            'Sign in success',
            style: TextStyle(color: Color(0xff151515)),
          ),
        ),
        backgroundColor: Color.fromRGBO(255, 204, 0, 1),
      ),
    );
  }

  void goMyHomepage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyHomePage(
              listCoin: widget.listCoin,
              idUser: idUser,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xff151515)),
        backgroundColor: const Color(0xff151515),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // email field
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        String emailRegex =
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                        RegExp regex = RegExp(emailRegex);
                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        email = value;
                      },
                    ),

                    const SizedBox(height: 16),
                    // password field
                    TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.white),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        if (value.contains(RegExp(r'[áàãâä]'))) {
                          return 'Password should not contain accented characters';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password = value;
                      },
                    ),

                    const SizedBox(height: 32),
                    // login button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Login logic
                          dataUser = {
                            "email": email,
                            "passWord": password,
                          };
                          NetworkRequestlogin networkRequestlogin =
                              NetworkRequestlogin(jsonBody: dataUser);
                          idUser = await networkRequestlogin.fetchPosts();
                          if (idUser == "login failed") {
                            notificationFailed();
                          } else {
                            goMyHomepage();
                            notificationsuccess();
                          }
                        }
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 1, 40)),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(255, 204, 0, 1),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Color(0xff151515)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Google and Facebook login buttons
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google login button
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(255, 204, 0, 1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/google_logo.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Sign In with Google',
                                style: TextStyle(color: Color(0xff151515)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Facebook login button
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(255, 204, 0, 1)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/facebook_logo.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Sign In with Facebook',
                                style: TextStyle(color: Color(0xff151515)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // "Don't have an account?" link
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SignUpPage(
                              listCoin: widget.listCoin,
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // "Forgot your password?" link
                    TextButton(
                      onPressed: () {
                        // Forgot password logic
                      },
                      child: const Text(
                        "Forgot your password?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
