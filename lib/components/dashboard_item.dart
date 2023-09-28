import 'package:flutter/material.dart';
import 'package:taskmate/constants.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    super.key,
    required this.title,
    required this.icon,
    this.function,
  });

  final String title;
  final IconData icon;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: function,
            child: ListTile(
              title: Text(title),
              leading: Icon(
                icon,
                color: kJetBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }
}