import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';

List<MenuItem> items = [
  new MenuItem<int>(
    id: 0,
    title: 'HOME',
    prefix: Icon(Icons.fastfood),
  ),
  new MenuItem<int>(
    id: 1,
    title: 'PROFILO',
    prefix: Icon(Icons.person),
  ),
  new MenuItem<int>(
    id: 2,
    title: 'GIOCATORI',
    prefix: Icon(Icons.terrain),
  ),
  new MenuItem<int>(
    id: 3,
    title: 'CIRCOLI',
    prefix: Icon(Icons.settings),
  ),
  new MenuItem<int>(
    id: 4,
    title: 'CONTATTACI',
    prefix: Icon(Icons.settings),
  ),
];
final menu = Menu(
  items: items.map((e) => e.copyWith(prefix: null)).toList(),
);

final menuWithIcon = Menu(
  items: items,
);
