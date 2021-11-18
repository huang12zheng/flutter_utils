import 'dart:async';

import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'client.dart';

// https://github.com/gql-dart/ferry/blob/master/examples/pokemon_explorer/lib/src/client.dart
// ignore: avoid_classes_with_only_static_members
/// Build app with Method [run]
///
/// Example:
/// ```dart
/// FerryUtil.run(materialApp);
/// ```
class FerryUtil {
  /// run [MaterialApp] as Async and do something prework
  static Future<void> run(Widget child, [String? name]) async {
    final store = await initStore(name);
    runApp(
      ProviderScope(overrides: [
        cacheProvider.overrideWithValue(StateController(Cache(store: store)))
      ], child: child),
    );
  }

  /// Builds a [HiveStore] for [Cache]
  ///
  /// Example:
  ///
  /// ```dart
  /// final store = await initStore(name);
  /// ```
  static Future<Store> initStore([String? name]) async {
    await Hive.initFlutter();

    final box = await Hive.openBox<Map<String, dynamic>>(name ?? 'graphql');

    return HiveStore(box);
  }
}
