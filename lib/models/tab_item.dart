import 'package:flutter/material.dart';

class TabItem {
  int index;
  String title;
  Widget icon;
  Widget page;

  TabItem({
    required this.index,
    required this.title,
    required this.icon,
    required this.page,
  });

  @override
  String toString() {
    return 'TabItem{index: $index, title: $title, icon: $icon, page: $page}';
  }
}
