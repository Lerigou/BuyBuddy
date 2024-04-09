import 'package:flutter/material.dart';
import 'package:buy_buddy_app/firebase_options.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String _baseUrl =
      'https://buybuddy-833fc-default-rtdb.firebaseio.com//user/.json';

      Future<void> addUser(Map<String, dynamic> userData) async {
    // Faz uma requisição POST para a URL base, enviando os dados do usuário codificados em JSON.
    final response =
        await http.post(Uri.parse(_baseUrl), body: json.encode(userData));
    // Verifica se a resposta da requisição não foi bem-sucedida.
    if (response.statusCode != 200) {
      // Trata a resposta não bem-sucedida aqui.
    } else {
      // Usuário adicionado com sucesso.
    }
  }
  // Função para adicionar uma lista de compras ao Firestore
  addShoppingList(String listName) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('shopping_lists').add({
      'name': listName,
      'items': [], // Começa com uma lista vazia de itens
    });
  }

  // Função para adicionar um item a uma lista de compras no Firestore
  addItemToList(uid, String newItem) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('shopping_lists').doc(uid).update({
      'items': FieldValue.arrayUnion(
          [newItem]), // Adiciona o novo item à lista existente
    });
  }
}


// CRUD de usuário

// Função para realizar o login do usuário.
login(email, password) async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância de FirebaseAuth.
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    // Tenta realizar o login com email e senha fornecidos.
    await auth.signInWithEmailAndPassword(email: email, password: password);
    // Verifica se o usuário está logado.
    if (auth.currentUser != null) {
      print('login deu boa');
      return true;
    } else {
      print('Deu ruim');
      return false;
    }
  } catch (e) {
    return false;
  }
}

// Função para realizar o logout do usuário.
logout() async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância de FirebaseAuth.
  FirebaseAuth auth = FirebaseAuth.instance;
  // Realiza o logout do usuário.
  auth.signOut();
}

// Função para registrar um novo usuário.
register(email, password, name) async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância de FirebaseAuth.
  FirebaseAuth auth = FirebaseAuth.instance;
  // Cria um novo usuário com email e senha fornecidos.
  var user = await auth.createUserWithEmailAndPassword(
      email: email, password: password);

  // Chama a função para registrar as informações adicionais do usuário.
  registerInfo(
    user.user!.uid,
    name,
    email
  );
}

// Função para registrar as informações adicionais do usuário no Firestore.
registerInfo(uid, name, email) async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância do FirebaseFirestore.
  FirebaseFirestore db = FirebaseFirestore.instance;
  // Adiciona as informações do usuário no Firestore.
  await db.collection('Users').doc(uid).set(
    {
      'name': name,
      'email': email
    },
  );
}

// Função para obter as informações do usuário do Firestore.
getUser() async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância do FirebaseFirestore.
  FirebaseFirestore db = FirebaseFirestore.instance;
  // Obtém o usuário atualmente logado.
  var checkUser = FirebaseAuth.instance.currentUser;
  // Obtém as informações do usuário do Firestore.
  var user = await db.collection('Users').doc(checkUser!.uid).get();
  // Retorna as informações do usuário.
  return user;
}

// Função para excluir o usuário e suas informações do Firestore.
deleteUser() async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância do FirebaseFirestore.
  FirebaseFirestore db = FirebaseFirestore.instance;
  // Obtém a instância de FirebaseAuth.
  var auth = FirebaseAuth.instance;
  // Exclui as informações do usuário do Firestore.
  await db.collection('Users').doc(auth.currentUser!.uid).delete();
  // Exclui o usuário.
  await auth.currentUser!.delete();
}

// Função para editar as informações do usuário no Firestore.
editUser(name) async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância de FirebaseAuth.
  FirebaseAuth user = FirebaseAuth.instance;
  // Obtém a instância do FirebaseFirestore.
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Define as novas informações do usuário no Firestore.
  await db.collection('Users').doc(user.currentUser!.uid).set({
    'name': name,
    'email': user.currentUser!.email
  });
}