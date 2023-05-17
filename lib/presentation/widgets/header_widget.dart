import 'package:flutter/material.dart';
class HeaderWidget extends StatelessWidget {
  final String header;
  const HeaderWidget({Key? key,required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        header,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
