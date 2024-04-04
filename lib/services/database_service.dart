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

  Future<void> addItem(String title, bool status, String itemId) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        body: json.encode({
          'id': itemId, // Adicionando o ID do item ao corpo da requisição
          'title': title,
          'status': status,
        }),
      );

      if (response.statusCode != 200) {
        print('Falha ao adicionar item: ${response.body}');
        throw Exception("Falha ao adicionar item ao banco de dados");
      } else {
        print('Item adicionado com sucesso: ${response.body}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Erro ao adicionar item ao banco de dados');
    }
  }

  Future<Map<String, dynamic>> getItems() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode != 200) {
        print('Falha ao obter itens: ${response.body}');
        throw Exception("Falha ao obter itens do banco de dados");
      } else {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Erro ao obter itens do banco de dados');
    }
  }

  Future<void> updateItem(String itemId, String title, bool newStatus) async {
    try {
      final url = '$_baseUrl/$itemId.json'; // Caminho para acessar o item no Firebase
      final response = await http.put(
        Uri.parse(url),
        body: json.encode({
          'id': itemId,
          'title': title,
          'status': newStatus,
        }),
      );

      if (response.statusCode != 200) {
        print('Falha ao atualizar item: ${response.body}');
        throw Exception("Falha ao atualizar item no banco de dados");
      } else {
        print('Item atualizado com sucesso: ${response.body}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Erro ao atualizar item no banco de dados');
    }
  }
}