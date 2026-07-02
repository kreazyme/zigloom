import 'package:example_template/common/theme.dart';
import 'package:example_template/gen/i18n/locale.dart';
import 'package:example_template/models/game_scenario.dart';
import 'package:example_template/pages/gameplay/gameplay_controller.dart';
import 'package:flutter/material.dart';

class GameplayBoard extends StatelessWidget {
  const GameplayBoard({
    super.key,
    required this.scenario,
    required this.controller,
  });

  final GameScenario scenario;
  final GameplayController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boardSize = constraints.maxWidth.clamp(280.0, 500.0);
        final gap = boardSize < 340 ? 4.0 : 5.0;
        final cellSize =
            (boardSize - gap * (scenario.columnCount - 1)) /
            scenario.columnCount;

        return Center(
          child: SizedBox.square(
            dimension: boardSize,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (details) => _selectFromOffset(
                context,
                details.localPosition,
                cellSize,
                gap,
              ),
              onPanStart: (details) => _selectFromOffset(
                context,
                details.localPosition,
                cellSize,
                gap,
              ),
              onPanUpdate: (details) => _selectFromOffset(
                context,
                details.localPosition,
                cellSize,
                gap,
              ),
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size.square(boardSize),
                    painter: _PathPainter(
                      path: controller.path,
                      cellSize: cellSize,
                      gap: gap,
                      isSolved: controller.isSolved,
                    ),
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: scenario.columnCount,
                      mainAxisSpacing: gap,
                      crossAxisSpacing: gap,
                    ),
                    itemCount: scenario.cellCount,
                    itemBuilder: (context, index) {
                      final point = GridPoint(
                        index ~/ scenario.columnCount,
                        index % scenario.columnCount,
                      );
                      final number = scenario.numberAt(point);
                      final isPath = controller.path.contains(point);

                      return BoardCell(
                        number: number,
                        isPath: isPath,
                        isHead: controller.path.last == point,
                        isInvalid: controller.invalidPoint == point,
                        isSolved: controller.isSolved,
                      );
                    },
                  ),
                  IgnorePointer(
                    child: CustomPaint(
                      size: Size.square(boardSize),
                      painter: _WallPainter(
                        walls: scenario.wallPositions,
                        cellSize: cellSize,
                        gap: gap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _selectFromOffset(
    BuildContext context,
    Offset offset,
    double cellSize,
    double gap,
  ) {
    final column = offset.dx ~/ (cellSize + gap);
    final row = offset.dy ~/ (cellSize + gap);
    final localX = offset.dx - column * (cellSize + gap);
    final localY = offset.dy - row * (cellSize + gap);

    if (localX < 0 ||
        localY < 0 ||
        localX > cellSize ||
        localY > cellSize ||
        row < 0 ||
        row >= scenario.rowCount ||
        column < 0 ||
        column >= scenario.columnCount) {
      return;
    }

    final solved = controller.extendPath(GridPoint(row, column));
    if (solved && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(context.t.gameplay.solved)));
    }
  }
}

class BoardCell extends StatelessWidget {
  const BoardCell({
    super.key,
    required this.number,
    required this.isPath,
    required this.isHead,
    required this.isInvalid,
    required this.isSolved,
  });

  final int? number;
  final bool isPath;
  final bool isHead;
  final bool isInvalid;
  final bool isSolved;

  @override
  Widget build(BuildContext context) {
    final gameTheme = Theme.of(context).extension<ZigloomGameTheme>()!;
    final isNumber = number != null;
    final borderColor = isInvalid
        ? AppTheme.actionOrange
        : isSolved
        ? AppTheme.starYellow
        : isHead
        ? AppTheme.white
        : isNumber
        ? AppTheme.cyanPale
        : AppTheme.white.withValues(alpha: 0.7);
    final cellColor = AppTheme.cyanPale.withValues(alpha: 0.94);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      transform: Matrix4.translationValues(isInvalid ? 3 : 0, 0, 0),
      decoration: BoxDecoration(
        gradient: isInvalid
            ? gameTheme.redGloss
            : isNumber || isPath
            ? gameTheme.blueGloss
            : null,
        color: isNumber || isPath || isInvalid ? null : cellColor,
        borderRadius: BorderRadius.circular(AppTheme.boardCellRadius),
        border: Border.all(color: borderColor, width: isHead ? 3 : 2),
        boxShadow: [
          if (isHead)
            BoxShadow(
              color: AppTheme.white.withValues(alpha: 0.46),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          if (isSolved)
            BoxShadow(
              color: AppTheme.starYellow.withValues(alpha: 0.32),
              blurRadius: 9,
              spreadRadius: 1,
            ),
        ],
      ),
      child: Center(
        child: number == null
            ? isHead
                  ? const Icon(
                      Icons.circle_rounded,
                      color: AppTheme.white,
                      size: 16,
                    )
                  : null
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    number.toString(),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppTheme.white,
                      fontSize: number! >= 10 ? 24 : 30,
                      fontStyle: FontStyle.italic,
                      shadows: gameTheme.textShadow,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class _PathPainter extends CustomPainter {
  const _PathPainter({
    required this.path,
    required this.cellSize,
    required this.gap,
    required this.isSolved,
  });

  final List<GridPoint> path;
  final double cellSize;
  final double gap;
  final bool isSolved;

  @override
  void paint(Canvas canvas, Size size) {
    if (path.length < 2) {
      return;
    }

    final points = path.map(_centerOf).toList();
    final shadowPaint = Paint()
      ..color = AppTheme.blueDeep.withValues(alpha: 0.55)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = cellSize * 0.34
      ..style = PaintingStyle.stroke;
    final pathPaint = Paint()
      ..color = isSolved ? AppTheme.starYellow : AppTheme.blueHighlight
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = cellSize * 0.22
      ..style = PaintingStyle.stroke;

    for (var index = 0; index < points.length - 1; index += 1) {
      canvas.drawLine(points[index], points[index + 1], shadowPaint);
      canvas.drawLine(points[index], points[index + 1], pathPaint);
    }
  }

  Offset _centerOf(GridPoint point) {
    return Offset(
      point.column * (cellSize + gap) + cellSize / 2,
      point.row * (cellSize + gap) + cellSize / 2,
    );
  }

  @override
  bool shouldRepaint(covariant _PathPainter oldDelegate) {
    return oldDelegate.path != path ||
        oldDelegate.cellSize != cellSize ||
        oldDelegate.gap != gap ||
        oldDelegate.isSolved != isSolved;
  }
}

class _WallPainter extends CustomPainter {
  const _WallPainter({
    required this.walls,
    required this.cellSize,
    required this.gap,
  });

  final List<WallSegment> walls;
  final double cellSize;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    if (walls.isEmpty) {
      return;
    }

    final shadowPaint = Paint()
      ..color = AppTheme.white.withValues(alpha: 0.85)
      ..strokeCap = StrokeCap.square
      ..strokeWidth = gap + 7;
    final wallPaint = Paint()
      ..color = const Color(0xFF2E2926)
      ..strokeCap = StrokeCap.square
      ..strokeWidth = gap + 4;

    for (final wall in walls) {
      final line = _lineFor(wall);
      canvas.drawLine(line.$1, line.$2, shadowPaint);
      canvas.drawLine(line.$1, line.$2, wallPaint);
    }
  }

  (Offset, Offset) _lineFor(WallSegment wall) {
    final left = wall.column * (cellSize + gap);
    final top = wall.row * (cellSize + gap);

    return switch (wall.orientation) {
      WallOrientation.horizontal => (
        Offset(left, top + cellSize + gap / 2),
        Offset(left + cellSize, top + cellSize + gap / 2),
      ),
      WallOrientation.vertical => (
        Offset(left + cellSize + gap / 2, top),
        Offset(left + cellSize + gap / 2, top + cellSize),
      ),
    };
  }

  @override
  bool shouldRepaint(covariant _WallPainter oldDelegate) {
    return oldDelegate.walls != walls ||
        oldDelegate.cellSize != cellSize ||
        oldDelegate.gap != gap;
  }
}
