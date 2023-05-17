import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:exchange/cubit/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/style/colors.dart';
import '../views/currency_item_view.dart';

class HistoryScreen extends StatefulWidget {
  static String route = '/historyScreen';

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late CurrencyCubit cubit;
  @override
  void initState() {
   cubit=BlocProvider.of(context);
   cubit.getTimeSeriesData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.scaffoldBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: MyColors.scaffoldBackgroundColor,
          leading: const BackButton(color: MyColors.mainColor),
          title: const Text(
            'History',
            style: TextStyle(
                color: MyColors.mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                letterSpacing: 1),
          ),
        ),
        body: BlocBuilder<CurrencyCubit, CurrencyState>(
          builder: (context, state) {
            return ConditionalBuilder(
              condition: cubit.timeSeriesData.isNotEmpty,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 28.0, horizontal: 20.0),
                  child: ListView.separated(itemBuilder: (context, index) {
                    return CurrencyItemView(
                      rate: cubit.timeSeriesData[index],
                    );
                  },
                      separatorBuilder: (context, index) =>const  Divider(),
                      itemCount: cubit.timeSeriesData.length),
                );
              }, fallback: (BuildContext context) {
                return const Center(child: CircularProgressIndicator(),);
            },
            );
          },
        )
    );
  }
}
