import 'package:ferry/ferry.dart';
import 'package:gql/ast.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import '../config.dart';
import 'link.dart';

/// {@template ferry.splitLink}
/// Creates a [Link] using by [LinkFactory.clientLink]
///
/// Hint:
/// - you can also Customize [HttpLink] and [WebSocketLink] by yourself.
/// - or just use `SplitLink.fromConfig(Configuration config)`
/// {@endtemplate}
class SplitLink extends Link {
  /// Creates with [Link]
  SplitLink(this.httpLink, this.wsLink);

  /// Creates a [SplitLink] with Configuration
  factory SplitLink.fromConfig(Configuration config) => SplitLink(
      HttpLink(config.apiEndpoint),
      WebSocketLink(
        config.wsEndpoint,
        // initialPayload: config.payload,
      ));

  /// Creates with [Configuration.apiEndpoint]
  final HttpLink httpLink;

  /// Creates with [Configuration.wsEndpoint]
  final WebSocketLink wsLink;

  @override
  Stream<Response> request(
    Request request, [
    NextLink? forward,
  ]) async* {
    final isSubscription = request.operation.document.definitions.any(
      (definition) =>
          definition is OperationDefinitionNode &&
          definition.type == OperationType.subscription,
    );
    if (isSubscription) {
      yield* wsLink.request(request);
    } else {
      yield* httpLink.request(request);
    }
  }
}
