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
