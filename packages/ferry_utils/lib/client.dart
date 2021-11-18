import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'link/link.dart';

/// A Provider for using [Client]
///
/// {@template ferry.clientState}
/// which watches [linkState] and [cacheProvider],return [Client]
/// {@endtemplate}
final clientProvider = StateProvider<Client>((ref) {
  final link = ref.watch(linkState);
  final cache = ref.watch(cacheProvider);
  return Client(link: link, cache: cache);
});

// #skip
/// A Provider for using [Cache]
// #resume
final cacheProvider = StateProvider<Cache>((ref) => Cache());
