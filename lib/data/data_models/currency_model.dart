
class Currency {
  dynamic data;
  String? code;
  Currency({this.data, this.code});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      data: json['description'],
      code: json['code'],
    );
  }
}

List<Currency> parseSymbolsList(Map<String,dynamic> json) {
  return json.entries
      .map((entry) =>  Currency.fromJson(entry.value))
      .toList();

}

List<Currency> parseRatesList(Map<String,dynamic> json) {
  return json.entries
      .map((entry) =>  Currency(code: entry.key,data: entry.value))
      .toList();

}
