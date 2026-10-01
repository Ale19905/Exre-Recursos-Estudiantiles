import 'package:flutter/material.dart';

import '../main.dart';
import '../theme/app_theme.dart';
import '../widgets/resource_list_card.dart';
import 'detail_screen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);

    final percentage = appState.completionPercentage;
    final completed = appState.completedCount;
    final pending = appState.pendingCount;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      children: [
        const Text(
          'Progreso',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Revisa tu avance en los recursos de estudio',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 22),

        // Porcentaje principal
        // Progreso general
Container(
  padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
  decoration: BoxDecoration(
    color: AppTheme.surface,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: AppTheme.border,
    ),
  ),
  child: Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              '${(percentage * 100).round()}%',
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$completed completados',
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '$pending pendientes',
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),

      const SizedBox(height: 12),

      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: percentage,
          minHeight: 6,
          backgroundColor: AppTheme.border,
          valueColor: const AlwaysStoppedAnimation<Color>(
            AppTheme.primary,
          ),
        ),
      ),
    ],
  ),
),

const SizedBox(height: 28),

        const SizedBox(height: 28),

        const Text(
          'Resumen por categoría',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 12),

        ...appState.categories
            .where((category) => category != 'Todas')
            .map(
              (category) => _CategoryProgress(
                category: category,
                total: appState.resources
                    .where(
                      (resource) =>
                          resource.category == category,
                    )
                    .length,
                completed: appState.completedResources
                    .where(
                      (resource) =>
                          resource.category == category,
                    )
                    .length,
              ),
            ),

        const SizedBox(height: 28),

        const Text(
          'Recursos completados',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 12),

        if (appState.completedResources.isEmpty)
          const _NoCompletedResources()
        else
          ...appState.completedResources.map(
            (resource) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ResourceListCard(
                resource: resource,
                isFavorite:
                    appState.isFavorite(resource.id),
                isCompleted: true,
                onFavoriteToggle: () {
                  appState.toggleFavorite(resource.id);
                },
                onTap: () {
                  appState.selectResource(resource.id);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(
                        resource: resource,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}


class _CategoryProgress extends StatelessWidget {
  final String category;
  final int total;
  final int completed;

  const _CategoryProgress({
    required this.category,
    required this.total,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    final value = total == 0 ? 0.0 : completed / total;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppTheme.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '$completed / $total',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 7,
                backgroundColor: AppTheme.border,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(
                  AppTheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoCompletedResources extends StatelessWidget {
  const _NoCompletedResources();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.school_outlined,
            color: AppTheme.textTertiary,
            size: 40,
          ),
          SizedBox(height: 10),
          Text(
            'Todavía no has completado recursos',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Marca un recurso como completado para verlo aquí.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textTertiary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}