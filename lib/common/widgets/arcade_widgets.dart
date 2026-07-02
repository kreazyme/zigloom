import 'package:example_template/common/theme.dart';
import 'package:flutter/material.dart';

class ArcadeBackdrop extends StatelessWidget {
  const ArcadeBackdrop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1397D8), AppTheme.cyanPale],
        ),
      ),
      child: child,
    );
  }
}

class ArcadeTitle extends StatelessWidget {
  const ArcadeTitle({
    super.key,
    required this.text,
    this.fontSize,
    this.maxLines = 1,
  });

  final String text;
  final double? fontSize;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        Theme.of(context).textTheme.displayLarge ??
        const TextStyle(fontSize: 52, fontWeight: FontWeight.w900);
    final style = baseStyle.copyWith(fontSize: fontSize);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Stack(
        children: [
          Text(
            text,
            maxLines: maxLines,
            textAlign: TextAlign.center,
            style: style.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 7
                ..color = AppTheme.inkBlue,
              shadows: const [
                Shadow(
                  color: AppTheme.blueDeep,
                  blurRadius: 0,
                  offset: Offset(4, 5),
                ),
              ],
            ),
          ),
          Text(
            text,
            maxLines: maxLines,
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: AppTheme.white,
              shadows: const [
                Shadow(
                  color: AppTheme.blueHighlight,
                  blurRadius: 0,
                  offset: Offset(0, -1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArcadePanel extends StatelessWidget {
  const ArcadePanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final gameTheme = Theme.of(context).extension<ZigloomGameTheme>()!;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: gameTheme.blueGloss,
        borderRadius: BorderRadius.circular(AppTheme.panelRadius),
        border: Border.all(
          color: AppTheme.white.withValues(alpha: 0.72),
          width: 2,
        ),
        boxShadow: gameTheme.tileShadow,
      ),
      child: child,
    );
  }
}

class ArcadeGlossyButton extends StatefulWidget {
  const ArcadeGlossyButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isSecondary = false,
    this.height,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isSecondary;
  final double? height;
  final IconData? icon;

  @override
  State<ArcadeGlossyButton> createState() => _ArcadeGlossyButtonState();
}

class _ArcadeGlossyButtonState extends State<ArcadeGlossyButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameTheme = theme.extension<ZigloomGameTheme>()!;
    final isEnabled = widget.onPressed != null;
    final borderColor = widget.isSecondary
        ? AppTheme.cyanPale
        : AppTheme.white.withValues(alpha: 0.86);

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: widget.label,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 90),
        scale: _isPressed ? 0.98 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 90),
          transform: Matrix4.translationValues(0, _isPressed ? 4 : 0, 0),
          decoration: BoxDecoration(
            gradient: isEnabled ? gameTheme.blueGloss : null,
            color: isEnabled ? null : AppTheme.blueBase.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: isEnabled
                ? (_isPressed
                      ? gameTheme.buttonShadow.take(1).toList()
                      : gameTheme.buttonShadow)
                : const [],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
              onTap: widget.onPressed,
              onHighlightChanged: isEnabled
                  ? (value) {
                      if (_isPressed != value) {
                        setState(() => _isPressed = value);
                      }
                    }
                  : null,
              child: SizedBox(
                width: double.infinity,
                height: widget.height ?? (widget.isSecondary ? 54 : 60),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, color: AppTheme.white, size: 23),
                          const SizedBox(width: 10),
                        ],
                        Flexible(
                          child: Text(
                            widget.label,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontSize: widget.isSecondary ? 15 : 18,
                              color: AppTheme.white,
                              shadows: isEnabled ? gameTheme.textShadow : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ArcadeCircleButton extends StatefulWidget {
  const ArcadeCircleButton({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.isYellow = false,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isYellow;

  @override
  State<ArcadeCircleButton> createState() => _ArcadeCircleButtonState();
}

class _ArcadeCircleButtonState extends State<ArcadeCircleButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final gameTheme = Theme.of(context).extension<ZigloomGameTheme>()!;
    final isEnabled = widget.onPressed != null;

    return Tooltip(
      message: widget.tooltip,
      child: Semantics(
        button: true,
        enabled: isEnabled,
        label: widget.tooltip,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 90),
          transform: Matrix4.translationValues(0, _isPressed ? 3 : 0, 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: widget.isYellow
                ? gameTheme.starGloss
                : gameTheme.redGloss,
            border: Border.all(color: AppTheme.white, width: 3),
            boxShadow: isEnabled
                ? (_isPressed
                      ? gameTheme.redButtonShadow.take(1).toList()
                      : gameTheme.redButtonShadow)
                : const [],
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: widget.onPressed,
              onHighlightChanged: isEnabled
                  ? (value) {
                      if (_isPressed != value) {
                        setState(() => _isPressed = value);
                      }
                    }
                  : null,
              child: SizedBox.square(
                dimension: 54,
                child: Icon(
                  widget.icon,
                  color: widget.isYellow ? AppTheme.actionRed : AppTheme.white,
                  size: 29,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ArcadeLevelTile extends StatefulWidget {
  const ArcadeLevelTile({
    super.key,
    required this.number,
    required this.state,
    required this.onPressed,
    this.starCount = 0,
  });

  final int number;
  final ArcadeLevelTileState state;
  final VoidCallback? onPressed;
  final int starCount;

  @override
  State<ArcadeLevelTile> createState() => _ArcadeLevelTileState();
}

class _ArcadeLevelTileState extends State<ArcadeLevelTile> {
  bool _isPressed = false;

  bool get _isLocked => widget.state == ArcadeLevelTileState.locked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameTheme = theme.extension<ZigloomGameTheme>()!;
    final isCurrent = widget.state == ArcadeLevelTileState.current;
    final canPress = widget.onPressed != null && !_isLocked;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 18, child: _StarRow(count: widget.starCount)),
        const SizedBox(height: 4),
        Semantics(
          button: canPress,
          enabled: canPress,
          label: _isLocked ? 'Locked puzzle' : 'Puzzle ${widget.number}',
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 90),
            transform: Matrix4.translationValues(0, _isPressed ? 4 : 0, 0),
            decoration: BoxDecoration(
              gradient: _isLocked ? null : gameTheme.blueGloss,
              color: _isLocked
                  ? AppTheme.blueBase.withValues(alpha: 0.56)
                  : null,
              borderRadius: BorderRadius.circular(AppTheme.tileRadius),
              border: Border.all(
                color: isCurrent ? AppTheme.starYellow : AppTheme.cyanPale,
                width: isCurrent ? 3 : 2,
              ),
              boxShadow: _isLocked
                  ? const []
                  : (_isPressed
                        ? gameTheme.tileShadow.take(1).toList()
                        : gameTheme.tileShadow),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppTheme.tileRadius),
                onTap: canPress ? widget.onPressed : null,
                onHighlightChanged: canPress
                    ? (value) {
                        if (_isPressed != value) {
                          setState(() => _isPressed = value);
                        }
                      }
                    : null,
                child: SizedBox.square(
                  dimension: 74,
                  child: Center(
                    child: _isLocked
                        ? const Icon(
                            Icons.lock_rounded,
                            color: AppTheme.white,
                            size: 34,
                          )
                        : Text(
                            widget.number.toString(),
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontSize: widget.number >= 10 ? 34 : 42,
                              fontStyle: FontStyle.italic,
                              color: AppTheme.white,
                              shadows: gameTheme.textShadow,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum ArcadeLevelTileState { solved, current, available, locked }

class _StarRow extends StatelessWidget {
  const _StarRow({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count.clamp(0, 3), (index) {
        return Stack(
          alignment: Alignment.center,
          children: const [
            Icon(Icons.star_rounded, color: AppTheme.starOrange, size: 19),
            Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(
                Icons.star_rounded,
                color: AppTheme.starYellow,
                size: 16,
              ),
            ),
          ],
        );
      }),
    );
  }
}
