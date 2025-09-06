import 'package:flutter/material.dart';
import 'package:meal_mate/core/theming/custom_colors.dart';

class CustomSwitch extends StatefulWidget {
  final bool isOn;
  final String leftText;
  final String rightText;
  final Function(bool) onToggle;
  final Color? activeColor;
  final Color? inactiveColor;

  const CustomSwitch({
    Key? key,
    required this.isOn,
    required this.leftText,
    required this.rightText,
    required this.onToggle,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.isOn) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOn != oldWidget.isOn) {
      widget.isOn
          ? _animationController.forward()
          : _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => widget.onToggle(!widget.isOn),
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: colors.switchBorder, width: 2),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  left: _animation.value * 60,
                  top: 1,
                  child: Container(
                    width: 56,
                    height: 44,
                    decoration: BoxDecoration(
                      color:
                          widget.isOn
                              ? (widget.activeColor ?? colors.primary)
                              : (widget.inactiveColor ??
                                  colors.switchInactiveText),
                      borderRadius: BorderRadius.circular(21),
                      boxShadow: [
                        BoxShadow(
                          color: colors.switchShadow,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              left: 15,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  widget.leftText,
                  style: TextStyle(
                    color:
                        !widget.isOn
                            ? colors.switchActiveText
                            : colors.switchInactiveText,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 15,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  widget.rightText,
                  style: TextStyle(
                    color:
                        widget.isOn
                            ? colors.switchActiveText
                            : colors.switchInactiveText,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
