import 'package:buy_buddy_app/pages/intro_page.dart';
import 'package:buy_buddy_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:buy_buddy_app/services/database_service.dart';
// Instância da classe DatabaseService

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({Key? key}) : super(key: key);

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  final DatabaseService _databaseService = DatabaseService();
  bool isLoading =
      false; // Define uma variável para controlar o estado de carregamento
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconPadding = screenWidth * 0.03;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 228, 192, 1),
      appBar: AppBar(
          leading: const BackButton(color: Color.fromRGBO(9, 129, 74, 1)),
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
                      "Faça o Cadastro",
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(9, 129, 74, 1),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: name,
                    style: TextStyle(
                      color: Color.fromRGBO(9, 129, 74, 1),
                      fontSize: 20.0,
                    ),
                    decoration: const InputDecoration(
                      label: Text(
                        'Nome de usuário',
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
                  TextFormField(
                    controller: confirmpassword,
                    obscureText: true,
                    style: TextStyle(
                      color: Color.fromRGBO(9, 129, 74, 1),
                      fontSize: 20.0,
                    ),
                    decoration: const InputDecoration(
                      label: Text(
                        'Confirmar Senha',
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
                register(email.text, password.text, name.text);

                setState(() {
                  // Atualiza o estado da tela
                  isLoading = true; // Define isLoading como true
                });

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Usuário cadastrado com sucesso'),
                  backgroundColor: Colors.green,
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(9, 129, 74, 1)),
                    borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.only(top: 24.0),
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
