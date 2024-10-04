import 'package:flutter/material.dart';

enum MessageColor{
  red(Colors.red),
  orange(Colors.orange),
  yellow(Colors.yellow),
  green(Colors.green),
  blue(Colors.blue),
  pink(Colors.pink),
  purple(Colors.purple),
  black(Colors.black);

  const MessageColor(this.rgbcolor);
    final Color rgbcolor;
  }
  


class GuestBookMessage {
  GuestBookMessage({required this.name, required this.color, required this.message});

  final String name;
  final String message;
  final String color;
}