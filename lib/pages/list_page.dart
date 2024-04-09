import 'package:buy_buddy_app/services/database_service.dart'; // Importando o serviço de banco de dados
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart'; // Importando a biblioteca UUID

class ListPage extends StatefulWidget {
  var listName; // Nome da lista
  var uid; // ID do usuário

  ListPage({Key? key, required this.uid, required this.listName})
      : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // final DatabaseService _databaseService = DatabaseService(); // Serviço de banco de dados (não está sendo utilizado no momento)
  // List<Map<String, dynamic>> _items = []; // Lista de itens (não está sendo utilizada no momento)
  // final _listKey = GlobalKey<FormState>(); // Chave para o formulário (não está sendo utilizada no momento)
  // String _title = ''; // Título (não está sendo utilizada no momento)
  TextEditingController titleController = TextEditingController(); // Controlador para o campo de texto do título
  // bool _suggest = false; // Variável de sugestão (não está sendo utilizada no momento)

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconPadding = screenWidth * 0.03;

    return Scaffold(
        backgroundColor: Color.fromRGBO(9, 129, 74, 1), // Cor de fundo da tela
        appBar: AppBar(
            leading: const BackButton(color: Color.fromRGBO(245, 228, 192, 1)), // Botão voltar
            title: const Text(
              "BuyBuddy", // Título da aplicação
              style: TextStyle(
                color: Color.fromRGBO(245, 228, 192, 1), // Cor do texto
                fontWeight: FontWeight.bold, // Peso da fonte
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: iconPadding),
                child: const Icon(
                  Icons.shopping_cart, // Ícone do carrinho de compras
                  color: Color.fromRGBO(245, 228, 192, 1), // Cor do ícone
                ),
              ),
            ],
            backgroundColor: const Color.fromRGBO(9, 129, 74, 1)), // Cor de fundo da barra de aplicativos
        body: FutureBuilder(
          future: getItem(widget.uid, widget.listName), // Obtendo a lista de itens
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Se a conexão estiver em estado de espera, mostra um indicador de progresso
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // Caso contrário, mostra a lista de itens
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 228, 192, 1), // Cor de fundo do contêiner
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 30.0),
                            child: Text(
                              widget.listName, // Nome da lista
                              style: TextStyle(
                                fontSize: 48.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(209, 96, 20, 1), // Cor do texto
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    openDialog(); // Abre o diálogo para adicionar um novo item
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: Colors
                                        .transparent, // Define o fundo como transparente
                                    elevation: 0,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Image.asset(
                                        'lib/utils/assets/images/add_icon.png'), // Ícone para adicionar um novo item
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Lógica para compartilhar lista
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .transparent, // Define o fundo como transparente
                                    padding: const EdgeInsets.all(10),
                                    elevation: 0,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Image.asset(
                                        'lib/utils/assets/images/share_icon.png'), // Ícone para compartilhar a lista
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data[widget.listName].length, // Número de itens na lista
                              itemBuilder: (context, index) {
                                List items = snapshot.data.values.toList();
                                print(items);
                                return ListTile(
                                  title: Text('${items[0][index]}'), // Exibe o título do item
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }

  openDialog() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Chave global para o formulário

    return showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        backgroundColor: Color.fromRGBO(245, 228, 192, 1), // Cor de fundo do diálogo
        content: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey, // Define a chave para o formulário
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Distribui o espaço entre os widgets
                    children: [
                      Text(
                        "Adicionar item", // Título do diálogo
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(209, 96, 20, 1), // Cor do texto
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Fecha o diálogo
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(5),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Icon(
                          Icons.cancel,
                          size: 30, // Defina o tamanho desejado do ícone
                          color: Color.fromRGBO(
                              209, 96, 20, 1), // Defina a cor desejada do ícone
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(9, 129, 74, 1),
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Novo item",
                      ),
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um item';
                        }
                        return null;
                      },
                      onSaved: (value) => null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {

                          await DatabaseService()
                              .addItemToList(widget.uid, titleController.text, widget.listName);
                              setState(() {
                                getItem(widget.uid, widget.listName);
                              });
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color.fromRGBO(
                                    9, 129, 74, 1); // Cor ao ser clicado
                              }
                              return Color.fromRGBO(
                                  245, 228, 192, 1); // Cor padrão
                            },
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color: Color.fromRGBO(9, 129, 74, 1)),
                            ),
                          ),
                        ),
                        child: Text(
                          'Adicionar',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(9, 129, 74, 1)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
