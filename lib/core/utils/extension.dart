import 'package:flutter/material.dart';

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

extension BuildContextExt on BuildContext {
  ThemeData get themeData => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
