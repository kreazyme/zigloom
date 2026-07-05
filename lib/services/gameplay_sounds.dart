import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameplaySoundsProvider = Provider<GameplaySounds>((ref) {
  final sounds = GameplaySounds();
  ref.onDispose(() => unawaited(sounds.dispose()));
  return sounds;
});

class GameplaySounds {
  GameplaySounds({
    AudioPlayer? scorePlayer,
    AudioPlayer? errorPlayer,
    AudioPlayer? successPlayer,
  }) : _scorePlayer = scorePlayer ?? AudioPlayer(playerId: 'gameplay_score'),
       _errorPlayer = errorPlayer ?? AudioPlayer(playerId: 'gameplay_error'),
       _successPlayer =
           successPlayer ?? AudioPlayer(playerId: 'gameplay_success');

  static const _scoreAsset = 'sounds/score.mp3';
  static const _errorAsset = 'sounds/error.mp3';
  static const _successAsset = 'sounds/success.mp3';

  final AudioPlayer _scorePlayer;
  final AudioPlayer _errorPlayer;
  final AudioPlayer _successPlayer;

  void numberedClueReached({required bool enabled}) {
    if (!enabled) {
      return;
    }

    unawaited(_play(_scorePlayer, _scoreAsset));
  }

  void invalidMove({required bool enabled}) {
    if (!enabled) {
      return;
    }

    unawaited(_play(_errorPlayer, _errorAsset));
  }

  void puzzleSolved({required bool enabled}) {
    if (!enabled) {
      return;
    }

    unawaited(_play(_successPlayer, _successAsset));
  }

  Future<void> dispose() async {
    await Future.wait([
      _scorePlayer.dispose(),
      _errorPlayer.dispose(),
      _successPlayer.dispose(),
    ]);
  }

  Future<void> _play(AudioPlayer player, String asset) async {
    await player.stop();
    await player.play(AssetSource(asset));
  }
}
