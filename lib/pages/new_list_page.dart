import 'package:buy_buddy_app/pages/list_page.dart';
import 'package:flutter/material.dart';
import 'package:buy_buddy_app/services/database_service.dart';
import 'package:flutter/widgets.dart';

class NewListPage extends StatefulWidget {
  const NewListPage({Key? key}) : super(key: key);

  @override
  State<NewListPage> createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  
  final DatabaseService _databaseService =
      DatabaseService(); // Instância da classe DatabaseService

  bool isLoading =
      false; // Define uma variável para controlar o estado de carregamento
  TextEditingController list_name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconPadding = screenWidth * 0.03;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(9, 129, 74, 1),
      appBar: AppBar(
          leading: const BackButton(color: Color.fromRGBO(245, 228, 192, 1)),
          title: const Text(
            "BuyBuddy",
            style: TextStyle(
              color: Color.fromRGBO(245, 228, 192, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: iconPadding),
              child: const Icon(
                Icons.shopping_cart,
                color: Color.fromRGBO(245, 228, 192, 1),
              ),
            ),
          ],
          backgroundColor: const Color.fromRGBO(9, 129, 74, 1)),
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
                      "Crie\nsua lista",
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(245, 228, 192, 1),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "e torne-a colaborativa compartilhando com seus amigos e familiares",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(245, 228, 192, 1),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: list_name,
                    style: TextStyle(
                      color: Color.fromRGBO(245, 228, 192, 1),
                      fontSize: 20.0,
                    ),
                    decoration: const InputDecoration(
                      label: Text(
                        'Nome da lista',
                        style: TextStyle(
                          color: Color.fromRGBO(245, 228, 192, 1),
                          fontSize: 18.0,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(245, 228, 192, 1),
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
                  await _databaseService.addShoppingList(list_name.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromRGBO(245, 228, 192, 1)),
                      borderRadius: BorderRadius.circular(30)),
                  margin: const EdgeInsets.only(top: 16.0),
                  padding: EdgeInsets.only(
                      left: 40.0, right: 40.0, top: 6.0, bottom: 6.0),
                  child: const Text(
                    "Criar lista",
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(245, 228, 192, 1)),
                  ),
                ),
              ),
            //btn criar
          ],
        ),
      ),
    );
  }
}
