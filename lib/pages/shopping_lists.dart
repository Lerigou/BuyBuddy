import 'package:buy_buddy_app/services/database_service.dart'; // Importando o serviço de banco de dados
import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key}); // Construtor da classe ShoppingList

  @override
  State<ShoppingList> createState() => _ShoppingListState(); // Cria o estado da classe ShoppingList
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 228, 192, 1), // Cor de fundo do Scaffold
      appBar: AppBar(backgroundColor: Color.fromRGBO(245, 228, 192, 1)), // Barra de aplicativos com cor de fundo específica
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Alinhamento cruzado no centro
        mainAxisAlignment: MainAxisAlignment.start, // Alinhamento principal no início
        children: [
          Text(
            "Lista de Compras", // Título da lista de compras
            style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(209, 96, 20,
                    1) // tive problemas pra pegar o hexadecimal, então o RGB serviu melhor nesse caso
                ),
          ),

          FutureBuilder(
            future: getItems(), // Obtém os itens futuros
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Se a conexão estiver em estado de espera, mostra um indicador de progresso
                return Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(), // Define um divisor entre os itens da lista
                    itemCount: snapshot.data!.length, // Número de itens na lista
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {}, // Ação ao tocar no item da lista
                        title: Text(
                          '${snapshot.data[index]}', // Exibe o título do item da lista
                          style: TextStyle(fontSize: 27), // Estilo do texto
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),

          // Btn criar
        ],
      ),
    );
  }
}
