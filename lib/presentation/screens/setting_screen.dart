

import 'package:exchange/cubit/currency_cubit.dart';
import 'package:exchange/presentation/screens/history_Screen.dart';
import 'package:exchange/presentation/widgets/currencies_btm_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/style/colors.dart';
import '../../shared/utilities.dart';
import '../widgets/exhange_rate_card.dart';

class SettingScreen extends StatefulWidget {
  static String route = '/settingScreen';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late CurrencyCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrencyCubit, CurrencyState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColors.scaffoldBackgroundColor,
          appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: MyColors.scaffoldBackgroundColor,
            leading: const BackButton(color: MyColors.mainColor),
            title: const Text(
              'Settings',
              style: TextStyle(
                  color: MyColors.mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  letterSpacing: 1),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Currency',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 28.0,
                            color: MyColors.mainColor),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Base',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: MyColors.smallTextColor),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Target',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: MyColors.smallTextColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showBtmSheet(
                                      context: context,
                                      btmSheetWidget: CurrenciesBtmSheet(
                                          isBase:true ,
                                          symbols: cubit.symbolsList),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cubit.selectedBase.code!,
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            color: MyColors.smallTextColor),
                                      ),
                                    const   Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: MyColors.smallTextColor,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    showBtmSheet(
                                      context: context,
                                      btmSheetWidget: CurrenciesBtmSheet(
                                          isBase:false ,
                                          symbols: cubit.symbolsList),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cubit.selectedTarget.code!,
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            color: MyColors.smallTextColor),
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: MyColors.smallTextColor,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0,),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'History',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 28.0,
                            color: MyColors.mainColor),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Start Date',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: MyColors.smallTextColor),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'End Date',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: MyColors.smallTextColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                              cubit.selectDate(context:context,isStart: true);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      convertDateToString(cubit.selectedStartDate),
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          color: MyColors.smallTextColor),
                                    ),
                                   const  Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: MyColors.smallTextColor,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              InkWell(
                                onTap: () {
                                  cubit.selectDate(context:context,isStart: false);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      convertDateToString(cubit.selectedEndDate),
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          color: MyColors.smallTextColor),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: MyColors.smallTextColor,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                     const  SizedBox(height: 20.0,),
                      ElevatedButton(onPressed: (){
                        Navigator.pushNamed(context, HistoryScreen.route);
                      }, child:const  Text('Get History'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

