import 'package:example_template/helper/shared_pref_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localDataProvider = Provider<SharedPrefHelper>(
  (ref) => SharedPrefHelper(),
);

final solvedPuzzleNumbersProvider = FutureProvider<Set<int>>((ref) {
  return ref.read(localDataProvider).solvedPuzzles.getData();
});
