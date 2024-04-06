import 'package:buy_buddy_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // Importando a biblioteca UUID

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final DatabaseService _databaseService = DatabaseService();
  List<Map<String, dynamic>> _items = [];
  final _listKey = GlobalKey<FormState>();
  String _title = '';
  bool _suggest = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconPadding = screenWidth * 0.03;

    return Scaffold(
      backgroundColor: Color.fromRGBO(9, 129, 74, 1),
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
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(245, 228, 192, 1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                    child: Text(
                      "Nome da lista",
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(209, 96, 20, 1),
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
                            openDialog();
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
                                'lib/utils/assets/images/add_icon.png'),
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
                                'lib/utils/assets/images/share_icon.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          activeColor: Color.fromRGBO(209, 96, 20, 1),
                          title: Text(
                            _items[index]['title'],
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          value: _items[index]['status'],
                          onChanged: (newStatus) {
                            setState(() {
                              _items[index]['status'] = newStatus;
                            });
                            // _databaseService.updateItem(_items[index]['id'],
                            //     _items[index]['title'], newStatus ?? false);
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  openDialog() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        backgroundColor: Color.fromRGBO(245, 228, 192, 1),
        content: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Distribui o espaço entre os widgets
                    children: [
                      Text(
                        "Adicionar item",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(209, 96, 20, 1),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
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
                      onSaved: (value) => _title = (value!),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          //   _formKey.currentState!.save();
                          //   String itemId =
                          //       Uuid().v4(); // Gera um UUID para o item
                          //   _databaseService
                          //       .addItem(_title, _suggest, itemId)
                          //       .then((_) {
                          //     setState(() {
                          //       _loadItems(); // Recarrega os itens após adicionar um novo
                          //     });
                          //     Navigator.of(cxt).pop();
                          //   }).catchError((error) {
                          //     print(
                          //         "Ocorreu um erro ao adicionar o item: $error");
                          //   });
                          // }
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
