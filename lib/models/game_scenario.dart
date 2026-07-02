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
class GridEdge {
  GridEdge(GridPoint first, GridPoint second)
    : assert(first.isAdjacentTo(second)),
      a = first.compareTo(second) <= 0 ? first : second,
      b = first.compareTo(second) <= 0 ? second : first;

  final GridPoint a;
  final GridPoint b;

  @override
  bool operator ==(Object other) {
    return other is GridEdge && other.a == a && other.b == b;
  }

  @override
  int get hashCode => Object.hash(a, b);
}

enum WallOrientation { horizontal, vertical }

@immutable
class WallSegment {
  const WallSegment({
    required this.orientation,
    required this.row,
    required this.column,
  });

  factory WallSegment.parse(String value) {
    final parts = value.split('_');
    if (parts.length != 3) {
      throw FormatException('Invalid wall segment', value);
    }

    final orientation = switch (parts[0]) {
      'H' => WallOrientation.horizontal,
      'V' => WallOrientation.vertical,
      _ => throw FormatException('Invalid wall orientation', value),
    };

    return WallSegment(
      orientation: orientation,
      row: int.parse(parts[1]),
      column: int.parse(parts[2]),
    );
  }

  final WallOrientation orientation;
  final int row;
  final int column;

  GridEdge get edge {
    final from = GridPoint(row, column);
    final to = switch (orientation) {
      WallOrientation.horizontal => GridPoint(row + 1, column),
      WallOrientation.vertical => GridPoint(row, column + 1),
    };

    return GridEdge(from, to);
  }

  String get key {
    final prefix = switch (orientation) {
      WallOrientation.horizontal => 'H',
      WallOrientation.vertical => 'V',
    };

    return '${prefix}_${row}_$column';
  }
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
    required this.wallPositions,
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
    final wallPositions = (json['wallPositions'] as List<dynamic>? ?? [])
        .cast<String>()
        .map(WallSegment.parse)
        .toList(growable: false);
    final metadataJson =
        (json['metadata'] as Map<String, dynamic>?) ?? const {};
    final metadata = GameScenarioMetadata.fromJson(metadataJson);
    final metadataSolutionPath =
        (metadataJson['solutionPath'] as List<dynamic>?)
            ?.cast<String>()
            .map(GridPoint.parse)
            .toList(growable: false);
    final solutionPath = metadataSolutionPath ?? path;
    final allPoints = [
      ...path,
      ...numberPositions.keys,
      ...solutionPath,
      for (final wall in wallPositions) wall.edge.a,
      for (final wall in wallPositions) wall.edge.b,
    ];
    final maxRow = allPoints.map((point) => point.row).fold<int>(0, _max);
    final maxColumn = allPoints.map((point) => point.column).fold<int>(0, _max);

    return GameScenario(
      id: json['id'] as String,
      puzzleNumber: puzzleNumber,
      rowCount: maxRow + 1,
      columnCount: maxColumn + 1,
      numberPositions: numberPositions,
      wallPositions: wallPositions,
      solutionPath: solutionPath,
      metadata: metadata,
    );
  }

  final String id;
  final int puzzleNumber;
  final int rowCount;
  final int columnCount;
  final Map<GridPoint, int> numberPositions;
  final List<WallSegment> wallPositions;
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

  bool hasWallBetween(GridPoint from, GridPoint to) {
    if (!from.isAdjacentTo(to)) {
      return false;
    }

    final edge = GridEdge(from, to);
    return wallPositions.any((wall) => wall.edge == edge);
  }
}

int _max(int a, int b) => a > b ? a : b;
