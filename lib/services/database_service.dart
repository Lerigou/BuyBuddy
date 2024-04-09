import 'package:flutter/material.dart'; // Importa o pacote de widgets do Flutter
import 'package:buy_buddy_app/firebase_options.dart'; // Importa as opções do Firebase
import 'package:http/http.dart' as http; // Importa o pacote HTTP para fazer requisições HTTP
import 'dart:convert'; // Importa o pacote para codificar e decodificar JSON
import 'package:firebase_auth/firebase_auth.dart'; // Importa o pacote FirebaseAuth para autenticação do Firebase
import 'package:firebase_core/firebase_core.dart'; // Importa o pacote FirebaseCore para inicializar o Firebase
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa o pacote CloudFirestore para usar o Firestore

class DatabaseService {
  final String _baseUrl =
      'https://buybuddy-833fc-default-rtdb.firebaseio.com//user/.json'; // URL base para o banco de dados Firebase

  // Função para adicionar um usuário ao banco de dados
  Future<void> addUser(Map<String, dynamic> userData) async {
    final response = await http.post(Uri.parse(_baseUrl), body: json.encode(userData)); // Faz uma requisição POST para adicionar o usuário
    if (response.statusCode != 200) {
      // Verifica se a resposta da requisição não foi bem-sucedida
      // Trata a resposta não bem-sucedida aqui
    } else {
      // Usuário adicionado com sucesso
    }
  }

  // Função para adicionar uma lista de compras ao Firestore
  addShoppingList(String listName) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
    FirebaseFirestore db = FirebaseFirestore.instance; // Instância do Firestore
    FirebaseAuth user = FirebaseAuth.instance; // Instância do FirebaseAuth

    String userId = user.currentUser!.uid; // ID do usuário atual
    DocumentReference userDocRef = db.collection('shopping_lists').doc(userId); // Referência do documento do usuário

    DocumentSnapshot userSnapshot = await userDocRef.get(); // Obtém o snapshot do documento do usuário

    if (userSnapshot.exists) {
      // Se o usuário existir
      await userDocRef.update({
        listName: [], // Adiciona o novo list name à lista existente
      });
    } else {
      // Se o usuário não existir
      await userDocRef.set({
        listName: [], // Cria um novo registro de lista de compras para o usuário
      });
    }

    await db.collection('shopping_lists').doc(user.currentUser!.uid).update(
      {
        listName: [], // Adiciona o novo list name à lista existente
      },
    );
  }

  // Função para adicionar um item a uma lista de compras no Firestore
  addItemToList(uid, newItem, listName) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
    FirebaseFirestore db = FirebaseFirestore.instance; // Instância do Firestore

    // Adiciona o novo item à lista existente no Firestore sem substituí-la
    await db.collection('shopping_lists').doc(uid).update({
      listName: FieldValue.arrayUnion([newItem]),
    });
  }
}

// Funções para gerenciar o usuário

// Função para realizar o login do usuário
login(email, password) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
  FirebaseAuth auth = FirebaseAuth.instance; // Instância do FirebaseAuth
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password); // Tenta fazer login com email e senha fornecidos
    if (auth.currentUser != null) {
      // Verifica se o usuário está logado
      print('login deu boa');
      return true; // Retorna true se o login for bem-sucedido
    } else {
      print('Deu ruim');
      return false; // Retorna false se o login falhar
    }
  } catch (e) {
    return false; // Retorna false se o login falhar
  }
}

// Função para realizar o logout do usuário
logout() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
  FirebaseAuth auth = FirebaseAuth.instance; // Instância do FirebaseAuth
  auth.signOut(); // Realiza o logout do usuário
}

// Função para registrar um novo usuário
register(email, password, name) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
  FirebaseAuth auth = FirebaseAuth.instance; // Instância do FirebaseAuth
  var user = await auth.createUserWithEmailAndPassword(email: email, password: password); // Cria um novo usuário com email e senha fornecidos
  registerInfo(user.user!.uid, name, email); // Registra as informações adicionais do usuário
}

// Função para registrar as informações adicionais do usuário no Firestore
registerInfo(uid, name, email) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
  FirebaseFirestore db = FirebaseFirestore.instance; // Instância do Firestore
  await db.collection('Users').doc(uid).set(
    {'name': name, 'email': email}, // Adiciona as informações do usuário no Firestore
  );
}

// Função para obter as informações do usuário do Firestore
getUser() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
  FirebaseFirestore db = FirebaseFirestore.instance; // Instância do Firestore
  var checkUser = FirebaseAuth.instance.currentUser; // Obtém o usuário atualmente logado
  var user = await db.collection('Users').doc(checkUser!.uid).get(); // Obtém as informações do usuário do Firestore
  return user; // Retorna as informações do usuário
}

// Função para verificar se há um usuário logado
check() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
  var checkUser = FirebaseAuth.instance.currentUser!.uid; // Obtém o UID do usuário atualmente logado
  return checkUser; // Retorna o UID do usuário
}

// Função para excluir o usuário e suas informações do Firestore
deleteUser() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
  FirebaseFirestore db = FirebaseFirestore.instance; // Instância do Firestore
  var auth = FirebaseAuth.instance; // Instância do FirebaseAuth
  await db.collection('Users').doc(auth.currentUser!.uid).delete(); // Exclui as informações do usuário do Firestore
  await auth.currentUser!.delete(); // Exclui o usuário
}

// Função para editar as informações do usuário no Firestore
editUser(name) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
  FirebaseAuth user = FirebaseAuth.instance; // Instância do FirebaseAuth
  FirebaseFirestore db = FirebaseFirestore.instance; // Instância do Firestore

  // Define as novas informações do usuário no Firestore
  await db
      .collection('Users')
      .doc(user.currentUser!.uid)
      .set({'name': name, 'email': user.currentUser!.email});
}

// Função para obter os itens de uma lista de compras do Firestore
getItem(uid, item) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
  FirebaseFirestore db = FirebaseFirestore.instance; // Instância do Firestore
  FirebaseAuth user = FirebaseAuth.instance; // Instância do FirebaseAuth
  var data = await db.collection('shopping_lists').doc(user.currentUser!.uid).get(); // Obtém os dados da lista de compras do usuário
  return data.data(); // Retorna os dados da lista de compras
}

// Função para obter os nomes dos itens de uma lista de compras do Firestore
getItems() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
  FirebaseFirestore db = FirebaseFirestore.instance; // Instância do Firestore
  FirebaseAuth user = FirebaseAuth.instance; // Instância do FirebaseAuth
  var data = await db.collection('shopping_lists').doc(user.currentUser!.uid).get(); // Obtém os dados da lista de compras do usuário
  return data.data()!.keys.toList(); // Retorna uma lista dos nomes dos itens da lista de compras
}
