import 'package:flutter/material.dart';

/// A boxed number that acts as the drag handle for a reorderable list item.
/// Replace every `ReorderableDragStartListener(index: i, child: Icon(drag_handle))`
/// with `NumberedDragHandle(index: i)`.
class NumberedDragHandle extends StatelessWidget {
  final int index;
  const NumberedDragHandle({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ReorderableDragStartListener(
      index: index,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: colors.outlineVariant),
          borderRadius: BorderRadius.circular(6),
          color: colors.surfaceContainerLow,
        ),
        child: Text(
          '${index + 1}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
