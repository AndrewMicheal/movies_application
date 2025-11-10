import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/app_colors.dart';

class SlidingSwitch extends StatefulWidget {
  final Widget firstImage;
  final Widget secondImage;
  final void Function(int)? onToggle;

  const SlidingSwitch({
    super.key,
    required this.firstImage,
    required this.secondImage,
    this.onToggle,
  });

  @override
  State<SlidingSwitch> createState() => _SlidingSwitchState();
}

class _SlidingSwitchState extends State<SlidingSwitch> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;
    return AnimatedToggleSwitch<int>.rolling(
      current: value,
      values: const [0, 1],
      onChanged: (newValue) {
        setState(() => value = newValue);
        if (widget.onToggle != null) {
          widget.onToggle!(newValue);
        }
      },
      iconBuilder: (i, size) {
        bool isSelected = value == i;
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? AppColors.yellow : Colors.transparent,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.all(4.0),
          child: ClipOval(
            child: SizedBox(
              width: 22,
              height: 23,
              child: i == 0 ? widget.firstImage : widget.secondImage,
            ),
          ),
        );
      },
      indicatorSize: const Size(60, 40),

      style: ToggleStyle(
        borderRadius: BorderRadius.circular(20),
        backgroundColor: AppColors.transparentColor,
        indicatorColor: AppColors.transparentColor,
        borderColor: AppColors.yellow,
      ),
    );
  }
}
