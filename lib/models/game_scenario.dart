import 'package:flutter/foundation.dart';

@immutable
class GridPoint implements Comparable<GridPoint> {
  const GridPoint(this.row, this.column);

  factory GridPoint.parse(String value) {
    final parts = value.split('-');
    if (parts.length != 2) {
      throw FormatException('Invalid grid point', value);
    }

    return GridPoint(int.parse(parts[0]), int.parse(parts[1]));
  }

  final int row;
  final int column;

  String get key => '$row-$column';

  bool isAdjacentTo(GridPoint other) {
    final rowDistance = (row - other.row).abs();
    final columnDistance = (column - other.column).abs();

    return rowDistance + columnDistance == 1;
  }

  @override
  int compareTo(GridPoint other) {
    final rowCompare = row.compareTo(other.row);
    return rowCompare == 0 ? column.compareTo(other.column) : rowCompare;
  }

  @override
  bool operator ==(Object other) {
    return other is GridPoint && other.row == row && other.column == column;
  }

  @override
  int get hashCode => Object.hash(row, column);

  @override
  String toString() => key;
}

@immutable
class GameScenarioMetadata {
  const GameScenarioMetadata({
    required this.checkpointCount,
    required this.lastNumber,
    required this.lastNumberCell,
    required this.uniqueSolution,
    required this.solutionCount,
    required this.solutionRule,
  });

  factory GameScenarioMetadata.fromJson(Map<String, dynamic> json) {
    return GameScenarioMetadata(
      checkpointCount: json['checkpointCount'] as int? ?? 0,
      lastNumber: json['lastNumber'] as int? ?? 0,
      lastNumberCell: json['lastNumberCell'] == null
          ? null
          : GridPoint.parse(json['lastNumberCell'] as String),
      uniqueSolution: json['uniqueSolution'] as bool? ?? false,
      solutionCount: json['solutionCount'] as int? ?? 0,
      solutionRule: json['solutionRule'] as String? ?? '',
    );
  }

  final int checkpointCount;
  final int lastNumber;
  final GridPoint? lastNumberCell;
  final bool uniqueSolution;
  final int solutionCount;
  final String solutionRule;
}

@immutable
class GameScenario {
  const GameScenario({
    required this.id,
    required this.puzzleNumber,
    required this.rowCount,
    required this.columnCount,
    required this.numberPositions,
    required this.solutionPath,
    required this.metadata,
  });

  factory GameScenario.fromResponse(
    Map<String, dynamic> json, {
    required int puzzleNumber,
  }) {
    final path = (json['path'] as List<dynamic>)
        .cast<String>()
        .map(GridPoint.parse)
        .toList(growable: false);
    final numberPositions = (json['numberPositions'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(GridPoint.parse(key), value as int));
    final metadataJson =
        (json['metadata'] as Map<String, dynamic>?) ?? const {};
    final metadata = GameScenarioMetadata.fromJson(metadataJson);
    final metadataSolutionPath =
        (metadataJson['solutionPath'] as List<dynamic>?)
            ?.cast<String>()
            .map(GridPoint.parse)
            .toList(growable: false);
    final solutionPath = metadataSolutionPath ?? path;
    final rowCount = json['rowCount'] as int?;
    final columnCount = json['columnCount'] as int?;
    final allPoints = [...path, ...numberPositions.keys, ...solutionPath];
    final maxRow = allPoints.map((point) => point.row).fold<int>(0, _max);
    final maxColumn = allPoints.map((point) => point.column).fold<int>(0, _max);

    return GameScenario(
      id: json['id'] as String,
      puzzleNumber: puzzleNumber,
      rowCount: rowCount ?? maxRow + 1,
      columnCount: columnCount ?? maxColumn + 1,
      numberPositions: numberPositions,
      solutionPath: solutionPath,
      metadata: metadata,
    );
  }

  final String id;
  final int puzzleNumber;
  final int rowCount;
  final int columnCount;
  final Map<GridPoint, int> numberPositions;
  final List<GridPoint> solutionPath;
  final GameScenarioMetadata metadata;

  int get cellCount => rowCount * columnCount;

  GridPoint get start {
    for (final entry in numberPositions.entries) {
      if (entry.value == 1) {
        return entry.key;
      }
    }

    return solutionPath.first;
  }

  int get lastNumber {
    if (metadata.lastNumber > 0) {
      return metadata.lastNumber;
    }

    return numberPositions.values.fold<int>(0, _max);
  }

  int? numberAt(GridPoint point) => numberPositions[point];

  bool contains(GridPoint point) {
    return point.row >= 0 &&
        point.row < rowCount &&
        point.column >= 0 &&
        point.column < columnCount;
  }
}

int _max(int a, int b) => a > b ? a : b;
