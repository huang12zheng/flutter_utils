import 'package:ferry/ferry.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show StateProvider;
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';

import '../config.dart';
import 'index.dart';

/// A Provider for using [Link],which would construct [Client]
///
/// {@macro ferry.clientLink}
///
/// Dependencies:
/// - [configState]
///
/// See also:
/// - [Configuration]
/// - [LinkFactory]
final linkState = StateProvider<Link>((ref) {
  final config = ref.watch(configState);
  return LinkFactory.fromConfig(config).clientLink;
});

/// Creates an [clientLink] with [Configuration]
class LinkFactory {
  /// Creates with [requestLink]
  LinkFactory(this.requestLink);

  /// Creates with [Configuration]
  factory LinkFactory.fromConfig(Configuration config) =>
      LinkFactory(SplitLink.fromConfig(config));

  /// Uses by [clientLink]
  ///
  /// {#macro ferry.splitLink}
  final SplitLink requestLink;

  /// Uses by [Client]
  ///
  /// {@template ferry.clientLink}
  /// [LinkFactory.clientLink],which is the used by [linkState],
  /// it is the result of [HttpLink],[WebSocketLink] and [LogLink],
  /// or the result of [logLink],[requestLink]
  /// {@endtemplate}
  ///
  /// Hint:
  /// - [Link.from] gives an order from first to last
  Link get clientLink => Link.from([logLink, requestLink]);

  /// Uses by [clientLink]
  LogLink get logLink => LogLink();
}
