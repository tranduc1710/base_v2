import 'package:flutter/material.dart';

abstract class AppInherited extends InheritedWidget {
  const AppInherited({super.key, required super.child});

  static T? maybeOf<T extends InheritedWidget>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<T>();
  }

  static T of<T extends InheritedWidget>(BuildContext context) {
    final T? result = maybeOf(context);
    assert(result != null, 'No $T found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
