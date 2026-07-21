import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String option;
  final int index;
  final int? selectedIndex;
  final ValueChanged<int> onTap;

  const OptionTile({
    super.key,
    required this.option,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool selected = selectedIndex == index;

    final Color primary = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: selected
              ? primary.withOpacity(.10)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? primary
                : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => onTap(index),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected
                        ? primary
                        : Colors.transparent,
                    border: Border.all(
                      color: selected
                          ? primary
                          : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: selected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),

                AnimatedSwitcher(
                  duration:
                      const Duration(milliseconds: 250),
                  child: selected
                      ? Icon(
                          Icons.check_circle,
                          key: const ValueKey("selected"),
                          color: primary,
                        )
                      : const SizedBox(
                          key: ValueKey("empty"),
                          width: 24,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}