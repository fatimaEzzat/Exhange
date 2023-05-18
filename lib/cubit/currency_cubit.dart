import 'dart:ffi';
import 'package:exchange/data/api/currency_api.dart';
import 'package:exchange/data/repo/curency_repo.dart';
import 'package:exchange/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:exchange/data/data_models/currency_model.dart';

part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit() : super(CurrencyInitial());

  static CurrencyCubit get(context) => BlocProvider.of<CurrencyCubit>(context);
  final _repo = CurrencyRepo(CurrencyApi());

  List<Currency> symbolsList = [];


  Future<void> getSupportedSymbols() async {
    emit(LoadingGetSupportedSymbolsState());
    _repo.getSupportedSymbols().then((value) {
      symbolsList = value;
      emit(SuccessGetSupportedSymbolsState());
    }).catchError((onError) {
      printDebug('error: ${onError.toString()}');
      emit(ErrorGetSupportedSymbolsState(onError.toString()));
    });
  }

  ///paginate supported list local
  int currentSymbolPage = 1;
  int symbolsPerPage = 10;
  List<Currency> paginatedSymbolsList = [];

  void getNextItems({bool getMore = false}) {
    emit(LoadInitialRecordeSate());
    if (getMore) {
      currentSymbolPage++;
      final startIndex = currentSymbolPage * symbolsPerPage;
      final endIndex = startIndex + symbolsPerPage;
      if (endIndex <= symbolsList.length - 1) {
        final nextItems = symbolsList.sublist(startIndex, endIndex);
        paginatedSymbolsList.addAll(nextItems);
      }
      emit(GetMoreSate());
    } else {
      currentSymbolPage = 1;
      paginatedSymbolsList = symbolsList.sublist(0, symbolsPerPage);
      emit(LoadInitialRecordeSate());
    }
  }


  ///get list of rates paginated based on symbol limits

  int currentRatePage = 1;
  int ratesPerPage = 10;
  List<Currency> paginatedRatesList = [];
  String? currentDate = '';

  void getPaginatedLatestRates({bool getMore = false}) {
    List<Currency> nextItems = [];
    late String limits;
    if (getMore) {
      currentRatePage++;
      final startIndex = currentRatePage * ratesPerPage;
      final endIndex = startIndex + ratesPerPage;
      if (endIndex <= symbolsList.length - 1) {
        nextItems = symbolsList.sublist(startIndex, endIndex);
        limits = nextItems.map((currency) => currency.code).join(',');
      } else {
        emit(ErrorGetLatestRatesStates('No More Items'));
        return;
      }
      emit(LoadingGetMoreLatestRatesState());
    } else {
      currentRatePage = 1;
      limits = symbolsList
          .sublist(0, ratesPerPage)
          .map((currency) => currency.code)
          .join(',');
      emit(LoadingGetLatestRatesState());
    }
    _repo.getLatestRates(queryMap: {'symbols': limits}).then((value) {
      if (getMore) {
        paginatedRatesList.addAll(value.item1);
      } else {
        paginatedRatesList = value.item1;
      }
      printDebug(value.item2);
      currentDate = value.item2;
      emit(SuccessGetLatestRatesStates());
    }).catchError((onError) {
      emit(ErrorGetLatestRatesStates(onError.toString()));
      printDebug('getPaginatedLatestRates error: $onError}');
    });
  }


  List<Currency> timeSeriesData = [];

  void getTimeSeriesData() {
    printDebug('start_date: ${DateFormat('yyyy-MM-dd').format(selectedStartDate)}, end_date:${DateFormat('yyyy-MM-dd').format(selectedEndDate)}');
    emit(LoadingGetTimeSeriesDataState());
    _repo
        .getTimeSeriesData(
        startDate: DateFormat('yyyy-MM-dd').format(selectedStartDate),
        endDate: DateFormat('yyyy-MM-dd').format(selectedEndDate))
        .then((value) {
      timeSeriesData = value;
      emit(SuccessGetTimeSeriesDataStates());
    }).catchError((error) {
      emit(ErrorGetTimeSeriesDataStates(error));
    });
  }


  ///select symbol.
  //initial with default values
  Currency selectedBase = const Currency(code: 'USD');
  Currency selectedTarget = const Currency(code: 'EGP');

  void selectSymbol({required Currency symbol, required bool isBase}) {
    if (isBase) {
      selectedBase = symbol;
      emit(SuccessSelectSymbolState());
    } else {
      selectedTarget = symbol;
      emit(SuccessSelectSymbolState());
    }
  }



  ///convert amount from currency to another

  double result = 0.0;

  void convertCurrency(
      {required String from, required String to, required String amount}) {
    _repo.convertCurrency(from: from, to: to, amount: amount).then((value) {
      result = value;
      emit(SuccessConvertCurrencyState());
    });
  }



  ///select date
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  Future<void> selectDate(
      {required BuildContext context, required bool isStart}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? selectedStartDate : selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedStartDate ||
        picked != selectedEndDate) {
      if (isStart) {
        selectedStartDate = picked!;
      } else {
        selectedEndDate = picked!;
      }
      emit(SuccessSelectDate());
    }
  }


}
