import 'package:exchange/cubit/currency_cubit.dart';
import 'package:exchange/data/data_models/currency_model.dart';
import 'package:exchange/presentation/widgets/header_widget.dart';
import 'package:exchange/shared/style/colors.dart';
import 'package:exchange/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrenciesBtmSheet extends StatefulWidget {

final bool isBase;
  final List<Currency> symbols;

  const CurrenciesBtmSheet({Key? key, required this.symbols,required this.isBase}) : super(key: key);

  @override
  State<CurrenciesBtmSheet> createState() => _CurrenciesBtmSheetState();
}

class _CurrenciesBtmSheetState extends State<CurrenciesBtmSheet> {
  late CurrencyCubit cubit;
  final ScrollController _scrollController = ScrollController();
  bool isSelected = false;
  int selectedIndex = -1;

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      CurrencyCubit.get(context).getNextItems(getMore: true);
    }
  }

  void selectItem(int index) {
    setState(() {
      selectedIndex = index;
    });
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    cubit.getNextItems();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 5.0,
                  width: 100.0,
                  decoration: const BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: HeaderWidget(header: 'currencies')),
            const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
            BlocConsumer<CurrencyCubit, CurrencyState>(
              listener: (context, state) {
                if(state is SuccessSelectSymbolState){
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: cubit.paginatedSymbolsList.length, (context, index) {
                    return SizedBox(
                      height: 60,
                      child: InkWell(
                        onTap: () {
                          cubit.selectSymbol(
                              symbol:
                              cubit.paginatedSymbolsList[index],
                              isBase: widget.isBase);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cubit.paginatedSymbolsList[index].code!,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              cubit.paginatedSymbolsList[index].data!,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const Divider()
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
