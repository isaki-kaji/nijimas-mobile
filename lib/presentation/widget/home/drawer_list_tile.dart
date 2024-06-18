import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({super.key, required this.title, required this.onTap});
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Center(child: Text(title)),
        onTap: onTap,
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Divider(),
      ),
    ]);
  }
}
