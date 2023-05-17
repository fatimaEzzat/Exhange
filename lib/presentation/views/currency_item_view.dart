import 'package:exchange/data/data_models/currency_model.dart';
import 'package:flutter/material.dart';

class CurrencyItemView extends StatelessWidget {
  final Currency rate;
  const CurrencyItemView({Key? key,required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(rate.code!,style: Theme.of(context).textTheme.headlineSmall,),
          ],
        ),
        trailing:Column(
          children: [
            Text(rate.data.toString(),style: Theme.of(context).textTheme.headlineSmall,),
          ],
        ),
      ),
    );
  }
}
