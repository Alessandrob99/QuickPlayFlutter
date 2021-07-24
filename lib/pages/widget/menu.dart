import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';

List<MenuItem> items = [
  new MenuItem<int>(
    id: 0,
    title: 'HOME',
    prefix: Icon(Icons.home),
  ),
  new MenuItem<int>(
    id: 1,
    title: 'PROFILO',
    prefix: Icon(Icons.person),
  ),
  new MenuItem<int>(
    id: 2,
    title: 'GIOCATORI',
    prefix: Icon(Icons.sports_football),
  ),
  new MenuItem<int>(
    id: 3,
    title: 'CIRCOLI',
    prefix: Icon(Icons.map),
  ),
  new MenuItem<int>(
    id: 4,
    title: 'CONTATTACI',
    prefix: Icon(Icons.info),
  ),
];
final menu = Menu(
  items: items.map((e) => e.copyWith(prefix: null)).toList(),
);

final menuWithIcon = Menu(
  items: items,
);
