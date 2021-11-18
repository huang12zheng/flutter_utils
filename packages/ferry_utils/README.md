<!-- This file uses generated code. Visit https://pub.dev/packages/readme_helper for usage information. -->
# FerryUtils

<!-- #toc -->
## Table of Contents

[**Source From**](#source-from)

[**Features**](#features)
  - [clientState](#clientstate)
  - [custom client](#custom-client)
  - [linkState](#linkstate)
  - [usage](#usage)
<!-- // end of #toc -->

## Source From
[ferrygraphql](https://ferrygraphql.com/)

Ferry is a highly productive, full-featured, extensible GraphQL Client for Flutter & Dart. Get started with ferry now.


## Features
### clientState
<!-- #code lib/client.dart ignore:import -->
 A Provider for using [Client]

 which watches [linkState] and [cacheProvider],return [Client]

```dart
final clientProvider = StateProvider<Client>((ref) {
  final link = ref.watch(linkState);
  final cache = ref.watch(cacheProvider);
  return Client(link: link, cache: cache);
});

final cacheProvider = StateProvider<Cache>((ref) => Cache());

```
<!-- // end of #code -->
### custom client
<!-- #code lib/client_ext.dart ignore:import ignoreComment ignoreSourceDoc -->
 Build app with Method [run]

 Example:
 ```dart
 FerryUtil.run(materialApp);
 ```
```dart
class FerryUtil {
  static Future<void> run(Widget child, [String? name]) async {
    final store = await initStore(name);
    runApp(
      ProviderScope(overrides: [
        cacheProvider.overrideWithValue(StateController(Cache(store: store)))
      ], child: child),
    );
  }

  static Future<Store> initStore([String? name]) async {
    await Hive.initFlutter();

    final box = await Hive.openBox<Map<String, dynamic>>(name ?? 'graphql');

    return HiveStore(box);
  }
}

```
<!-- // end of #code -->
<!-- #code lib/config.dart ignore:import ignoreDoc -->
```dart



final configState = StateProvider((ref) => const Configuration());

```
<!-- // end of #code -->

### linkState
<!-- #code lib/link/link.dart ignore:import ignoreSourceDoc -->
 A Provider for using [Link],which would construct [Client]


 Dependencies:
 - [configState]

 See also:
 - [Configuration]
 - [LinkFactory]
```dart
final linkState = StateProvider<Link>((ref) {
  final config = ref.watch(configState);
  return LinkFactory.fromConfig(config).clientLink;
});

```
 Creates an [clientLink] with [Configuration]
```dart
class LinkFactory {
  LinkFactory(this.requestLink);

  factory LinkFactory.fromConfig(Configuration config) =>
      LinkFactory(SplitLink.fromConfig(config));

  final SplitLink requestLink;

  Link get clientLink => Link.from([logLink, requestLink]);

  LogLink get logLink => LogLink();
}

```
<!-- // end of #code -->