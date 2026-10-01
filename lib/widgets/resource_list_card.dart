import 'package:flutter/material.dart';

import '../models/study_resource.dart';
import '../theme/app_theme.dart';

class ResourceListCard extends StatelessWidget {
  final StudyResource resource;
  final bool isFavorite;
  final bool isCompleted;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const ResourceListCard({
    super.key,
    required this.resource,
    required this.isFavorite,
    required this.isCompleted,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  Color _categoryColor() {
    switch (resource.category) {
      case 'Flutter':
        return AppTheme.flutter;
      case 'Android':
        return AppTheme.android;
      case 'Layouts':
        return AppTheme.layouts;
      case 'Scrollables':
        return AppTheme.scrollables;
      case 'Slivers':
        return AppTheme.slivers;
      case 'Navegación':
        return AppTheme.navigation;
      default:
        return AppTheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _categoryColor();

    return Material(
      color: AppTheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.border,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _typeIcon(),
                  color: categoryColor,
                  size: 30,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            resource.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: onFavoriteToggle,
                          child: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite
                                ? AppTheme.favorite
                                : AppTheme.textTertiary,
                            size: 21,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: categoryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        resource.category,
                        style: TextStyle(
                          color: categoryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      resource.author,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(
                          Icons.schedule_outlined,
                          color: AppTheme.textTertiary,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${resource.durationMinutes} min',
                          style: const TextStyle(
                            color: AppTheme.textTertiary,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          resource.level,
                          style: const TextStyle(
                            color: AppTheme.textTertiary,
                            fontSize: 11,
                          ),
                        ),
                        if (isCompleted) ...[
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.check_circle,
                            color: AppTheme.success,
                            size: 15,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _typeIcon() {
    switch (resource.type) {
      case 'Video':
        return Icons.play_circle_outline;
      case 'Lectura':
        return Icons.menu_book_outlined;
      case 'Práctica':
        return Icons.code;
      case 'Documento':
        return Icons.description_outlined;
      default:
        return Icons.school_outlined;
    }
  }
}