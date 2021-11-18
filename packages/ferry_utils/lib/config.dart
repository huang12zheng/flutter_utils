import 'package:equatable/equatable.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';

import 'client.dart';
import 'link/link.dart';

// #skip
/// A Config that used for generate [Client]
///
/// The [Configuration.apiEndpoint] describes [HttpLink] and
/// The [Configuration.wsEndpoint] describes [WebSocketLink],
///
/// {@macro ferry.client}
///
/// In this package, using [configState] to get [Configuration]
///
/// Example:
/// ```dart
/// final configState = StateProvider((ref) => Configuration());
/// {@template ferry.configuration}
/// final config = ref.watch(configState);
/// {@endtemplate}
/// ```
///
/// See also:
///
/// - [clientProvider], {@macro ferry.clientState}
/// - [LinkFactory]
class Configuration extends Equatable {
  /// Construct of [Configuration]
  const Configuration(
      {this.apiEndpoint = 'http://localhost:4000/',
      this.wsEndpoint = 'ws://localhost:4000/'});

  /// endpoint of httpLink
  final String apiEndpoint;

  /// endpoint of webSocket
  final String wsEndpoint;
  @override
  List<Object> get props => [apiEndpoint, wsEndpoint];
}
// #resume

/// A Provider for using [Configuration]
///
/// {@macro ferry.configuration}
///
/// See also:
/// - [linkState],
final configState = StateProvider((ref) => const Configuration());
