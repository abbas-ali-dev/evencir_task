import 'package:flutter/material.dart';

Widget customTab(int index, IconData icon, String text) {
  return Tab(
    icon: Icon(
      icon,
      color: Colors.white,
    ),
    text: text,
  );
}
