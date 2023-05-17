// import 'package:flutter/material.dart';
//
// import '../views/currency_item_view.dart';
//
// class OtherCurrenciesCard extends StatelessWidget {
//   const OtherCurrenciesCard({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  Padding(
//       padding: const EdgeInsets.only(top: 32.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Other currencies',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           const SizedBox(
//             height: 16.0,
//           ),
//           ListView.builder(
//             scrollDirection: Axis.vertical,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return const CurrencyItemView();
//             },
//             itemCount: 25,
//           )
//         ],
//       ),
//     );
//   }
// }
