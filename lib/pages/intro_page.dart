import 'package:buy_buddy_app/pages/join_page.dart';
import 'package:buy_buddy_app/pages/list_page.dart';
import 'package:buy_buddy_app/pages/new_list_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 228, 192, 1),
      body: Center(
        child: Column(
          children: [
            //logo
            Padding(
              padding: const EdgeInsets.only(left: 175.0, top: 10.0),
              child: Transform.scale(
                scale: 1.1, // Defina a escala desejada (1.0 é a escala original)
                child: Image.asset(
                  'lib/utils/assets/images/shopping_kart.png',
                ),
              ),
            ),
        
            Spacer(),
            const Padding(
              padding: EdgeInsets.only(left: 54.0, top: 00.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Buy Buddy",
                  style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(209, 96, 20,
                          1) // tive problemas pra pegar o hexadecimal, então o RGB serviu melhor nesse caso
                      ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 54.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sua lista de compras na palma da mão",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        
            // Btn criar
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const NewListPage();
              })),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(9, 129, 74, 1),
                    borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.only(top: 100.0),
                padding: EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 6.0, bottom: 6.0),
                child: const Text(
                  "Criar uma lista",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(245, 228, 192, 1)),
                ),
              ),
            ),
        
            // Btn entrar
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const JoinPage();
              })),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(9, 129, 74, 1)),
                    borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.only(top: 16.0),
                padding: EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 6.0, bottom: 6.0),
                child: const Text(
                  "Entrar",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(9, 129, 74, 1)),
                ),
              ),
            ),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
}
