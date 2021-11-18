// inspired from https://github.com/britannio/ferry_log_plugin/blob/master/lib/log_link.dart
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:gql_exec/gql_exec.dart';

/// A Middleware that handle record [Request]
///
/// through [request], you can record [Operation.operationName] in [Request].
class LogLink extends Link {
  @override
  Stream<Response> request(
    Request request, [
    NextLink? forward,
  ]) async* {
    // onRequest(request);
    debugPrint('[GraphQL] ${request.operation.operationName}');

    await for (final response in forward!(request)) {
      // onResponse(response);
      yield response;
    }
  }
}
