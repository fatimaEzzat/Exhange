import 'package:exchange/cubit/currency_cubit.dart';
import 'package:flutter/material.dart';

import '../../shared/style/colors.dart';
import '../../shared/utilities.dart';
import 'currencies_btm_sheet.dart';

class ExchangeRateCard extends StatefulWidget {
  final Function(String value) onSubmitted;
  final double result;
  final Function() onSelectBase;
  final Function() onSelectTarget;
  const ExchangeRateCard({Key? key,required this.onSubmitted,required this.result,required this.onSelectBase,required this.onSelectTarget}) : super(key: key);

  @override
  State<ExchangeRateCard> createState() => _ExchangeRateCardState();
}

class _ExchangeRateCardState extends State<ExchangeRateCard> {
  bool exchange = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
        // width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.37,
        decoration: const BoxDecoration(
          color: MyColors.mainColor,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Column(
          children: [
             Text(
               widget.result.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      !exchange ? 'From ' : 'To ',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    InkWell(
                      onTap: widget.onSelectBase,
                      child: Container(
                        width: 100,
                        height: 60,
                        decoration: const BoxDecoration(
                            color: MyColors.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              CurrencyCubit.get(context).selectedBase.code!,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.black54,
                            )
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        exchange = !exchange;
                      });
                    },
                    icon: Icon(
                      exchange ? Icons.arrow_back : Icons.arrow_forward,
                      size: 27,
                      color: MyColors.smallTextColor,
                    )),
                Column(
                  children: [
                    Text(
                      !exchange ? 'To' : 'From ',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    InkWell(
                      onTap: widget.onSelectTarget,
                      child: Container(
                        width: 100,
                        height: 60,
                        decoration: const BoxDecoration(
                            color: MyColors.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                CurrencyCubit.get(context).selectedTarget.code!,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    'Amount ',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50.0,
                      child: TextFormField(
                        onFieldSubmitted: widget.onSubmitted,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 23.0),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: MyColors.primaryColor), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                BorderSide(width: 3, color: Colors.blueAccent),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
