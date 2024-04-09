import 'package:buy_buddy_app/pages/intro_page.dart';
import 'package:buy_buddy_app/pages/list_page.dart';
import 'package:buy_buddy_app/pages/new_list_page.dart';
import 'package:buy_buddy_app/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:buy_buddy_app/services/database_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final DatabaseService _databaseService =
      DatabaseService(); // Instância da classe DatabaseService



  bool isLoading =
      false; // Define uma variável para controlar o estado de carregamento
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconPadding = screenWidth * 0.03;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 228, 192, 1),
      appBar: AppBar(
          title: const Text(
            "BuyBuddy",
            style: TextStyle(
              color: Color.fromRGBO(9, 129, 74, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: iconPadding),
              child: const Icon(
                Icons.shopping_cart,
                color: Color.fromRGBO(9, 129, 74, 1),
              ),
            ),
          ],
          backgroundColor: Color.fromRGBO(245, 228, 192, 1)),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Faça o Login",
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(9, 129, 74, 1),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: email,
                    style: TextStyle(
                      color: Color.fromRGBO(9, 129, 74, 1),
                      fontSize: 20.0,
                    ),
                    decoration: const InputDecoration(
                      label: Text(
                        'Email',
                        style: TextStyle(
                          color: Color.fromRGBO(9, 129, 74, 1),
                          fontSize: 18.0,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(9, 129, 74, 1),
                          width: 3.0, // Largura da borda
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    style: TextStyle(
                      color: Color.fromRGBO(9, 129, 74, 1),
                      fontSize: 20.0,
                    ),
                    decoration: const InputDecoration(
                      label: Text(
                        'Senha',
                        style: TextStyle(
                          color: Color.fromRGBO(9, 129, 74, 1),
                          fontSize: 18.0,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(9, 129, 74, 1),
                          width: 3.0, // Largura da borda
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                var checklogin = await login(email.text, password.text);
                if (checklogin == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IntroPage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Email ou senha incorretos.'),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(9, 129, 74, 1)),
                    borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.only(top: 24.0),
                padding: EdgeInsets.only(
                    left: 60.0, right: 60.0, top: 6.0, bottom: 6.0),
                child: const Text(
                  "Entrar",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(9, 129, 74, 1)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SignupPage();
              })),
              child: Container(
                // decoration: BoxDecoration(
                //     border: Border.all(color: Color.fromRGBO(9, 129, 74, 1)),
                //     borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.only(top: 16.0),
                padding: EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 6.0, bottom: 6.0),
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(9, 129, 74, 1)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
