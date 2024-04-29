import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_theme/app_colors.dart';

/// A ThemeChip widget.
class ThemeChip extends StatefulWidget {
  final String text;
  final String? icon;
  final bool isSelected;
  final Function(int) onSelected;
  final int index;

  /// ThemeChip
  const ThemeChip({
    super.key,
    this.isSelected = false,
    required this.onSelected,
    required this.index,
    required this.text,
    this.icon,
  });

  @override
  State<ThemeChip> createState() => _ThemeChipState();
}

class _ThemeChipState extends State<ThemeChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
        bottom: 8,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          splashColor: AppColors.primaryColor,
          highlightColor: AppColors.primaryColor.withOpacity(.2),
          onTap: () => widget.onSelected(widget.index),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: widget.isSelected
                  ? Border.all(
                      color: AppColors.purpleColor,
                    )
                  : Border.all(
                      color: AppColors.purple2Color,
                    ),
              gradient: widget.isSelected
                  ? LinearGradient(
                      colors: [
                        const Color(0xffA48CE8).withOpacity(0.3),
                        const Color(0xffD191F9).withOpacity(0.3),
                      ],
                    )
                  : LinearGradient(
                      colors: [
                        const Color(0xff7760C9).withOpacity(0.1),
                        const Color(0xffBA68D4).withOpacity(0.1),
                      ],
                    ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  SvgPicture.asset(
                    widget.icon!,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.42,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
