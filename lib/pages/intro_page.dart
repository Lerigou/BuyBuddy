import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 228, 192, 1),
      body: Column(
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.only(left: 285.0),
            child: Image.asset('lib/utils/assets/images/shopping_kart.png'),
          ),

          Padding(
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
          Padding(
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
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(9, 129, 74, 1),
                borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.only(top: 100.0),
            padding:
                EdgeInsets.only(left: 40.0, right: 40.0, top: 6.0, bottom: 6.0),
            child: Text(
              "Criar uma lista",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(245, 228, 192, 1)),
            ),
          ),
          
          // Btn entrar
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(9, 129, 74, 1)),
                borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.only(top: 16.0),
            padding:
                EdgeInsets.only(left: 40.0, right: 40.0, top: 6.0, bottom: 6.0),
            child: Text(
              "Entrar",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(9, 129, 74, 1)),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
}
