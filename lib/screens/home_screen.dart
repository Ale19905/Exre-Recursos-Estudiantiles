import 'package:flutter/material.dart';

import '../main.dart';
import '../theme/app_theme.dart';
import '../widgets/quick_access_card.dart';
import '../widgets/stat_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        const Text(
          'BIENVENIDO A',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          'ExRE',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 34,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Explorador de Recursos de Estudio',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 24),

        _LifecycleCard(
          state: appState.lifecycleState,
          message: appState.lifecycleMessage,
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: StatCard(
                value: '${appState.resources.length}',
                label: 'Disponibles',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                value: '${appState.favoriteIds.length}',
                label: 'Favoritos',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                value: '${appState.completedIds.length}',
                label: 'Completados',
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        const Text(
          'Accesos rápidos',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 14),

        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.15,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            QuickAccessCard(
              icon: Icons.menu_book_outlined,
              title: 'Catálogo',
              color: const Color(0xFF0EA5E9),
              onTap: () {
                AppStateProvider.of(context).changeTab(1);
              },
            ),
            QuickAccessCard(
              icon: Icons.grid_view_outlined,
              title: 'Galería',
              color: const Color(0xFF7B39ED),
              onTap: () {
                AppStateProvider.of(context).changeTab(2);
              },
            ),
            QuickAccessCard(
              icon: Icons.favorite_border,
              title: 'Favoritos',
              color: const Color(0xFFF5405E),
              onTap: () {
                AppStateProvider.of(context).changeTab(3);
              },
            ),
            QuickAccessCard(
              icon: Icons.bar_chart_outlined,
              title: 'Progreso',
              color: const Color(0xFF15A349),
              onTap: () {
                AppStateProvider.of(context).changeTab(4);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _LifecycleCard extends StatelessWidget {
  final AppLifecycleState state;
  final String message;

  const _LifecycleCard({
    required this.state,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.monitor_heart_outlined,
              color: AppTheme.primary,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Estado del ciclo de vida',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  state.name,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: const TextStyle(
                    color: AppTheme.textTertiary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}