import 'package:exchange/cubit/currency_cubit.dart';
import 'package:exchange/presentation/screens/home_screen.dart';
import 'package:exchange/shared/style/colors.dart';
import 'package:exchange/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  static String route = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    CurrencyCubit.get(context).getSupportedSymbols();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrencyCubit, CurrencyState>(
      listener: (context, state) {
        if(state is SuccessGetSupportedSymbolsState){
          Navigator.pushNamed(context, HomeScreen.route);
        }if(state is ErrorGetSupportedSymbolsState){
          showToast(msg: state.error, state: ToastedStates.ERROR);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: MyColors.scaffoldBackgroundColor,
            body: Center(
              child: RichText(
                text: const TextSpan(
                  text: 'Ex',
                  style: TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                      letterSpacing: 1.2),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'change',
                        style: TextStyle(
                          color: MyColors.mainColor,
                        )),
                  ],
                ),
              ),
            ),


          ),
        );
      },
    );
  }
}
