import 'dart:convert';

import 'package:example_template/models/game_scenario.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const zipLoomWorkerBaseUrl = 'https://live-score-worker.kreazy-dev.workers.dev';
const zipLoomKvInstance = 'ZIP_LOOM';
const zipLoomScenarioKey = '8x8';

final gameScenarioRepositoryProvider = Provider<GameScenarioRepository>(
  (ref) => GameScenarioRepository(),
);

final gameScenariosProvider = FutureProvider<List<GameScenario>>((ref) {
  return ref.read(gameScenarioRepositoryProvider).fetchScenarios();
});

final gameScenarioProvider = FutureProvider.family<GameScenario, int>((
  ref,
  puzzleNumber,
) async {
  final scenarios = await ref.watch(gameScenariosProvider.future);

  return scenarios.firstWhere(
    (scenario) => scenario.puzzleNumber == puzzleNumber,
    orElse: () => scenarios.first,
  );
});

class GameScenarioRepository {
  GameScenarioRepository({http.Client? client, Uri? baseUri})
    : _client = client ?? http.Client(),
      _baseUri = baseUri ?? Uri.parse(zipLoomWorkerBaseUrl);

  final http.Client _client;
  final Uri _baseUri;

  Future<List<GameScenario>> fetchScenarios() async {
    final response = await _client.get(_scenarioUri);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw GameScenarioException(
        'Worker returned HTTP ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(response.body);
    return _parseScenarioPayload(decoded);
  }

  Uri get _scenarioUri {
    return _baseUri.replace(
      pathSegments: ['kv', zipLoomKvInstance, zipLoomScenarioKey],
    );
  }

  List<GameScenario> _parseScenarioPayload(Object? payload) {
    final scenarios = switch (payload) {
      List() => _parseScenarioList(payload),
      Map<String, dynamic>() => _parseScenarioMap(payload),
      _ => throw const GameScenarioException(
        'KV value is not a scenario payload',
      ),
    };

    if (scenarios.isEmpty) {
      throw const GameScenarioException('KV value does not contain scenarios');
    }

    return scenarios;
  }

  List<GameScenario> _parseScenarioMap(Map<String, dynamic> payload) {
    final scenarios = payload['scenarios'];
    if (scenarios is List) {
      return _parseScenarioList(scenarios);
    }

    return [GameScenario.fromResponse(payload, puzzleNumber: 1)];
  }

  List<GameScenario> _parseScenarioList(List<dynamic> payload) {
    return payload
        .whereType<Map<String, dynamic>>()
        .toList(growable: false)
        .asMap()
        .entries
        .map((entry) {
          final json = entry.value;
          final puzzleNumber = json['puzzleNumber'] as int? ?? entry.key + 1;

          return GameScenario.fromResponse(json, puzzleNumber: puzzleNumber);
        })
        .toList(growable: false);
  }
}

class GameScenarioException implements Exception {
  const GameScenarioException(this.message);

  final String message;

  @override
  String toString() => message;
}
