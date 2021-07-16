// To parse this JSON data, do
//
//     final customerInfo = customerInfoFromJson(jsonString);
import 'dart:convert';

List<CustomerInfo> customerInfoFromJson(String str) => List<CustomerInfo>.from(
    json.decode(str).map((x) => CustomerInfo.fromJson(x)));

String customerInfoToJson(List<CustomerInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerInfo {
  CustomerInfo({
    required this.designation,
    required this.firstname,
    required this.lastname,
    required this.id,
    required this.balance,
    required this.phone,
    required this.dpurl,
  });

  String designation;
  String firstname;
  String lastname;
  String id;
  double balance;
  String phone;
  String dpurl;

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
        designation: json["designation"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        id: json["id"],
        balance: json["balance"].toDouble(),
        phone: json["phone"],
        dpurl: json["dpurl"],
      );

  Map<String, dynamic> toJson() => {
        "designation": designation,
        "firstname": firstname,
        "lastname": lastname,
        "id": id,
        "balance": balance,
        "phone": phone,
        "dpurl": dpurl,
      };
}
