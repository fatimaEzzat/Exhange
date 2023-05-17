part of 'currency_cubit.dart';

@immutable
abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class LoadingGetSupportedSymbolsState extends CurrencyState {}

class SuccessGetSupportedSymbolsState extends CurrencyState {}

class ErrorGetSupportedSymbolsState extends CurrencyState {
  final String error;

  ErrorGetSupportedSymbolsState(this.error);
}

class LoadInitialRecordeSate extends CurrencyState {}

class GetMoreSate extends CurrencyState {}

class SuccessSelectSymbolState extends CurrencyState {}

class SuccessConvertCurrencyState extends CurrencyState {}

class LoadingGetMoreLatestRatesState extends CurrencyState {}

class LoadingGetLatestRatesState extends CurrencyState {}

class SuccessGetLatestRatesStates extends CurrencyState {}

class ErrorGetLatestRatesStates extends CurrencyState {
  final String error;

  ErrorGetLatestRatesStates(this.error);
}


class SuccessSelectDate extends CurrencyState {}

class LoadingGetTimeSeriesDataState extends CurrencyState {}

class SuccessGetTimeSeriesDataStates extends CurrencyState {}

class ErrorGetTimeSeriesDataStates extends CurrencyState {
  final String error;

  ErrorGetTimeSeriesDataStates(this.error);
}