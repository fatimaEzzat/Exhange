import 'package:exchange/cubit/currency_cubit.dart';
import 'package:exchange/data/api/currency_api.dart';
import 'package:exchange/data/repo/curency_repo.dart';
import 'package:exchange/presentation/screens/setting_screen.dart';
import 'package:exchange/presentation/widgets/header_widget.dart';
import 'package:exchange/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../shared/utilities.dart';
import '../views/currency_item_view.dart';
import '../widgets/currencies_btm_sheet.dart';
import '../widgets/current_currency_card.dart';
import '../widgets/exhange_rate_card.dart';
import '../widgets/other_currencires_card.dart';

class HomeScreen extends StatefulWidget {
  static String route = '/homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  late CurrencyCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    cubit.getPaginatedLatestRates();
    cubit.convertCurrency(
        from: cubit.selectedBase.code!,
        to: cubit.selectedTarget.code!,
        amount: '1');
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      cubit.getPaginatedLatestRates(getMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrencyCubit, CurrencyState>(
      listener: (context, state) {
        if (state is LoadingGetMoreLatestRatesState) {
          showToast(msg: 'Get More Rates', state: ToastedStates.SUCCESS);
        } else if (state is ErrorGetLatestRatesStates) {
          if (state.error == 'No More Items') {
            showToast(msg: state.error, state: ToastedStates.ERROR);
          }
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: RichText(
              text: const TextSpan(
                text: 'Ex',
                style: TextStyle(
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
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
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SettingScreen.route);
                  },
                  icon: Image.asset(
                    'assets/images/menu.png',
                    width: 25.0,
                    color: MyColors.mainColor,
                  ))
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(10.0),
              child: state is LoadingGetMoreLatestRatesState
                  ? const LinearProgressIndicator()
                  : Container(),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomScrollView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                slivers: [
                   SliverToBoxAdapter(
                    child: CurrentCurrencyCard(date: cubit.currentDate!,),
                  ),
                  const SliverToBoxAdapter(
                    child: HeaderWidget(
                      header: 'Exchange rate',
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: ExchangeRateCard(
                    onSubmitted: (value) {
                      cubit.convertCurrency(
                          from: cubit.selectedBase.code!,
                          to: cubit.selectedTarget.code!,
                          amount: value);
                    },
                    result: cubit.result,
                    onSelectBase: () {
                      showBtmSheet(
                        context: context,
                        btmSheetWidget: CurrenciesBtmSheet(
                            isBase: true, symbols: cubit.symbolsList),
                      );
                    },
                    onSelectTarget: () {
                      showBtmSheet(
                        context: context,
                        btmSheetWidget: CurrenciesBtmSheet(
                            isBase: false, symbols: cubit.symbolsList),
                      );
                    },
                  )),
                  const SliverToBoxAdapter(
                      child: HeaderWidget(
                    header: 'Other currencies',
                  )),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: cubit.paginatedRatesList.length,
                        (context, index) {
                      return CurrencyItemView(
                        rate: cubit.paginatedRatesList[index],
                      );
                    }),
                  ),
                  SliverToBoxAdapter(
                      child: state is ErrorGetLatestRatesStates
                          ? state.error == 'No More Items'
                              ?  Center(child: Text(state.error))
                              : Container()
                          : Container())
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
