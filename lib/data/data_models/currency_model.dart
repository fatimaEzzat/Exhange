import 'package:equatable/equatable.dart';
import 'package:exchange/shared/utilities.dart';

class Currency extends Equatable {
  final dynamic data;
  final String? code;

  const Currency({this.data, this.code});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      data: json['description'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'description': data,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [code, data];
}

List<Currency> parseSymbolsList(Map<String, dynamic> json) {
  return json.entries.map((entry) => Currency.fromJson(entry.value)).toList();
}

List<Currency> parseRatesList(Map<String, dynamic> json) {
  return json.entries
      .map((entry) => Currency(code: entry.key, data: entry.value))
      .toList();
}

Map<String, dynamic> parseListToMap(
    {required List<Currency> items, String? startDate}) {
  Map<String, dynamic> currencyMap = {};
  if (startDate == null) {
    for (Currency currency in items) {
      currencyMap[currency.code!] = currency.toMap();
    }
  } else {
    Map<String, dynamic> map = {};
    for (Currency currency in items) {
      map[currency.code!] = currency.data;
    }
    currencyMap[startDate]=map;
  }


  printDebug(currencyMap.toString());

  return currencyMap;
}
