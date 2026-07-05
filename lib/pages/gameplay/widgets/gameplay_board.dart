import 'dart:math' as math;

import 'package:example_template/common/theme.dart';
import 'package:example_template/models/game_scenario.dart';
import 'package:example_template/pages/gameplay/gameplay_controller.dart';
import 'package:flutter/material.dart';

class GameplayBoard extends StatefulWidget {
  const GameplayBoard({
    super.key,
    required this.scenario,
    required this.controller,
    required this.onMoveResult,
    required this.onSolved,
  });

  final GameScenario scenario;
  final GameplayController controller;
  final ValueChanged<GameplayMoveResult> onMoveResult;
  final VoidCallback onSolved;

  @override
  State<GameplayBoard> createState() => _GameplayBoardState();
}

class _GameplayBoardState extends State<GameplayBoard> {
  GridPoint? _lastDragPoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boardSize = constraints.maxWidth.clamp(280.0, 500.0);
        final gap = boardSize < 340 ? 1.5 : 2.0;
        final cellSize =
            (boardSize - gap * (widget.scenario.columnCount - 1)) /
            widget.scenario.columnCount;

        return Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.panelRadius),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.blueDeep.withValues(alpha: 0.24),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.panelRadius),
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
                  onPanStart: (details) {
                    _lastDragPoint = null;
                    _selectFromOffset(
                      context,
                      details.localPosition,
                      cellSize,
                      gap,
                      isDragUpdate: true,
                    );
                  },
                  onPanUpdate: (details) => _selectFromOffset(
                    context,
                    details.localPosition,
                    cellSize,
                    gap,
                    isDragUpdate: true,
                  ),
                  onPanEnd: (_) => _lastDragPoint = null,
                  onPanCancel: () => _lastDragPoint = null,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size.square(boardSize),
                        painter: _BoardGridPainter(
                          rowCount: widget.scenario.rowCount,
                          columnCount: widget.scenario.columnCount,
                          cellSize: cellSize,
                          gap: gap,
                        ),
                      ),
                      CustomPaint(
                        size: Size.square(boardSize),
                        painter: _PathPainter(
                          path: widget.controller.path,
                          cellSize: cellSize,
                          gap: gap,
                          isSolved: widget.controller.isSolved,
                        ),
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widget.scenario.columnCount,
                          mainAxisSpacing: gap,
                          crossAxisSpacing: gap,
                        ),
                        itemCount: widget.scenario.cellCount,
                        itemBuilder: (context, index) {
                          final point = GridPoint(
                            index ~/ widget.scenario.columnCount,
                            index % widget.scenario.columnCount,
                          );
                          final number = widget.scenario.numberAt(point);

                          return BoardCell(
                            number: number,
                            isHead: widget.controller.path.last == point,
                            isInvalid: widget.controller.invalidPoint == point,
                            invalidPulse: widget.controller.invalidPulse,
                            isSolved: widget.controller.isSolved,
                          );
                        },
                      ),
                    ],
                  ),
                ),
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
    double gap, {
    bool isDragUpdate = false,
  }) {
    final column = offset.dx ~/ (cellSize + gap);
    final row = offset.dy ~/ (cellSize + gap);
    final localX = offset.dx - column * (cellSize + gap);
    final localY = offset.dy - row * (cellSize + gap);

    if (localX < 0 ||
        localY < 0 ||
        localX > cellSize ||
        localY > cellSize ||
        row < 0 ||
        row >= widget.scenario.rowCount ||
        column < 0 ||
        column >= widget.scenario.columnCount) {
      return;
    }

    final point = GridPoint(row, column);
    if (isDragUpdate && point == _lastDragPoint) {
      return;
    }
    if (isDragUpdate) {
      _lastDragPoint = point;
    }

    final result = widget.controller.extendPath(point);
    widget.onMoveResult(result);

    if (result == GameplayMoveResult.solved) {
      widget.onSolved();
    }
  }
}

class _BoardGridPainter extends CustomPainter {
  const _BoardGridPainter({
    required this.rowCount,
    required this.columnCount,
    required this.cellSize,
    required this.gap,
  });

  final int rowCount;
  final int columnCount;
  final double cellSize;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()..color = AppTheme.blueDeep.withValues(alpha: 0.1);
    final cellPaint = Paint()
      ..color = Color.alphaBlend(
        AppTheme.white.withValues(alpha: 0.84),
        AppTheme.cyanPale,
      );

    canvas.drawRect(Offset.zero & size, gridPaint);

    for (var row = 0; row < rowCount; row += 1) {
      for (var column = 0; column < columnCount; column += 1) {
        final left = column * (cellSize + gap);
        final top = row * (cellSize + gap);
        canvas.drawRect(
          Rect.fromLTWH(left, top, cellSize, cellSize),
          cellPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BoardGridPainter oldDelegate) {
    return oldDelegate.rowCount != rowCount ||
        oldDelegate.columnCount != columnCount ||
        oldDelegate.cellSize != cellSize ||
        oldDelegate.gap != gap;
  }
}

class BoardCell extends StatelessWidget {
  const BoardCell({
    super.key,
    required this.number,
    required this.isHead,
    required this.isInvalid,
    required this.invalidPulse,
    required this.isSolved,
  });

  final int? number;
  final bool isHead;
  final bool isInvalid;
  final int invalidPulse;
  final bool isSolved;

  @override
  Widget build(BuildContext context) {
    final gameTheme = Theme.of(context).extension<ZigloomGameTheme>()!;
    final numberStyle = Theme.of(context).textTheme.displayMedium?.copyWith(
      color: AppTheme.inkBlue.withValues(alpha: 0.92),
      fontSize: number != null && number! >= 10 ? 18 : 22,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w900,
      shadows: const [],
    );

    return TweenAnimationBuilder<double>(
      key: ValueKey<int>(isInvalid ? invalidPulse : -1),
      tween: Tween(begin: 0, end: isInvalid ? 1 : 0),
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        final shake = isInvalid
            ? math.sin(value * math.pi * 4) * (1 - value) * 6
            : 0.0;
        final scale = isInvalid ? 1 + math.sin(value * math.pi) * 0.035 : 1.0;

        return Transform.translate(
          offset: Offset(shake, 0),
          child: Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              decoration: BoxDecoration(
                color: isInvalid
                    ? AppTheme.actionOrange.withValues(alpha: 0.28)
                    : Colors.transparent,
                border: Border.all(
                  color: isSolved && isHead
                      ? AppTheme.starYellow.withValues(alpha: 0.9)
                      : isHead
                      ? AppTheme.white.withValues(alpha: 0.78)
                      : Colors.transparent,
                  width: isHead ? 2 : 0,
                ),
                boxShadow: [
                  if (isHead)
                    BoxShadow(
                      color: AppTheme.white.withValues(alpha: 0.32),
                      blurRadius: 10,
                    ),
                  if (isInvalid)
                    BoxShadow(
                      color: AppTheme.actionOrange.withValues(alpha: 0.22),
                      blurRadius: 10,
                    ),
                ],
              ),
              child: Center(
                child: number == null
                    ? isHead
                          ? DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.white.withValues(alpha: 0.9),
                                boxShadow: gameTheme.tileShadow,
                              ),
                              child: const SizedBox.square(dimension: 10),
                            )
                          : null
                    : FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(number.toString(), style: numberStyle),
                        ),
                      ),
              ),
            ),
          ),
        );
      },
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
    final pathPaint = Paint()
      ..color = isSolved ? AppTheme.starYellow : AppTheme.blueBase
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = cellSize * 0.56
      ..style = PaintingStyle.stroke;
    final highlightPaint = Paint()
      ..color = AppTheme.white.withValues(alpha: 0.16)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = cellSize * 0.44
      ..style = PaintingStyle.stroke;
    final endPaint = Paint()
      ..color = isSolved
          ? AppTheme.starOrange.withValues(alpha: 0.38)
          : AppTheme.blueDeep.withValues(alpha: 0.2);

    for (var index = 0; index < points.length - 1; index += 1) {
      canvas.drawLine(points[index], points[index + 1], pathPaint);
      canvas.drawLine(points[index], points[index + 1], highlightPaint);
    }

    canvas.drawCircle(points.first, cellSize * 0.28, endPaint);
    canvas.drawCircle(points.last, cellSize * 0.28, endPaint);
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
