import 'package:flutter/material.dart';

class Cripto {
  final String name;
  final String symbol;
  final String date_added;
  final double price;

  Cripto({
    required this.name,
    required this.symbol,
    required this.date_added,
    required this.price,
  });

  static Cripto fromMap(Map<String, dynamic> MoedaMap) {
      double priceValue = 0.0;

  try {
    final quote = MoedaMap['quote'];
    if (quote != null && quote['USD'] != null && quote['USD']['price'] != null) {
      priceValue = (quote['USD']['price'] as num).toDouble();
    }
  } catch (e) {
    print('Erro ao ler preco: $e');
  }
    
    return Cripto(
      name: MoedaMap['name'],
      symbol: MoedaMap['symbol'],
      date_added: MoedaMap['date_added'],
      price: priceValue,
    );
  }
}