import 'package:buy_buddy_app/pages/edit_profile_page.dart';
import 'package:buy_buddy_app/pages/intro_page.dart';
import 'package:buy_buddy_app/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buy_buddy_app/services/database_service.dart';
import 'package:flutter/widgets.dart';
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
      body: FutureBuilder(
          future: getUser(), // Obtém os dados do usuário.
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Se o snapshot estiver em estado de espera.
              return Center(
                // Retorna um widget de Center.
                child:
                    CircularProgressIndicator(), // Indicador de progresso circular.
              );
            } else {

              return Center(
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
                              "Bem-vindo ao seu perfil!",
                              style: TextStyle(
                                fontSize: 48.0,
                                fontWeight: FontWeight.w900,
                                color: Color.fromRGBO(9, 129, 74, 1),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(9, 129, 74, 1)),
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.only(top: 24.0),
                            padding: EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "${snapshot.data['name']}",
                              style: TextStyle(
                                color: Color.fromRGBO(9, 129, 74, 1),
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(9, 129, 74, 1)),
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.only(top: 24.0),
                            padding: EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "${snapshot.data['email']}",
                              style: TextStyle(
                                color: Color.fromRGBO(9, 129, 74, 1),
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const EditProfilePage();
                      })),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(9, 129, 74, 1),
                            borderRadius: BorderRadius.circular(30)),
                        margin: const EdgeInsets.only(top: 100.0),
                        padding: EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 6.0, bottom: 6.0),
                        child: const Text(
                          "Editar perfil",
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(245, 228, 192, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
