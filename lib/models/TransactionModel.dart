import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    required this.txId,
    required this.toId,
    required this.fromId,
    required this.amount,
    required this.date,
  });

  final String txId;
  final String fromId;
  final String toId;
  final double amount;
  final DateTime date;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        txId: json["txid"],
        fromId: json["fromid"],
        toId: json["toid"],
        amount: json["amount"].toDouble(),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "txid": txId,
        "fromid": fromId,
        "toid": toId,
        "amount": amount,
        "date": date.toIso8601String(),
      };
}
