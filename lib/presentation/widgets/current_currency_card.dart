import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:exchange/cubit/currency_cubit.dart';
import 'package:flutter/material.dart';

import '../../shared/style/colors.dart';

class CurrentCurrencyCard extends StatelessWidget {
  final String date;

  const CurrentCurrencyCard({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 18.0),
      decoration: const BoxDecoration(
        color: MyColors.mainColor,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1 ${CurrencyCubit.get(context).selectedBase.code!}',
            style: const TextStyle(
              color: MyColors.smallTextColor,
              fontSize: 16.0,
            ),
          ),
          Row(
            children: [
              Text(
                CurrencyCubit.get(context).result.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '${CurrencyCubit.get(context).selectedTarget.code!}',
                style: const TextStyle(
                  color: MyColors.smallTextColor,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          ConditionalBuilder(
            condition: date != null,
            builder: (context) {
              return Text(
                date,
                style: TextStyle(
                  color: MyColors.smallTextColor,
                  fontSize: 16.0,
                ),
              );
            },
            fallback: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
