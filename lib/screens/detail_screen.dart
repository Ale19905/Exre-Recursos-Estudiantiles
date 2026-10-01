import 'package:flutter/material.dart';

import '../main.dart';
import '../models/study_resource.dart';
import '../theme/app_theme.dart';

class DetailScreen extends StatelessWidget {
  final StudyResource resource;

  const DetailScreen({
    super.key,
    required this.resource,
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

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final categoryColor = _categoryColor();

    final isFavorite = appState.isFavorite(resource.id);
    final isCompleted = appState.isCompleted(resource.id);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Detalle'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          // Imagen / representación del recurso
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.border,
              ),
            ),
            child: Center(
              child: Icon(
                _typeIcon(),
                size: 72,
                color: categoryColor,
              ),
            ),
          ),

          const SizedBox(height: 22),

          // Categoría
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  resource.category,
                  style: TextStyle(
                    color: categoryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              if (isCompleted)
                const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppTheme.success,
                      size: 17,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Completado',
                      style: TextStyle(
                        color: AppTheme.success,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Título
          Text(
            resource.title,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 28,
              height: 1.15,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 10),

          // Autor
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                color: AppTheme.textTertiary,
                size: 17,
              ),
              const SizedBox(width: 6),
              Text(
                resource.author,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Metadata
          Row(
            children: [
              Expanded(
                child: _MetadataItem(
                  icon: Icons.schedule_outlined,
                  label: 'Duración',
                  value: '${resource.durationMinutes} min',
                ),
              ),
              Expanded(
                child: _MetadataItem(
                  icon: Icons.signal_cellular_alt,
                  label: 'Nivel',
                  value: resource.level,
                ),
              ),
              Expanded(
                child: _MetadataItem(
                  icon: Icons.category_outlined,
                  label: 'Tipo',
                  value: resource.type,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          const Text(
            'Descripción',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 9),

          Text(
            resource.description,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
              height: 1.55,
            ),
          ),

          const SizedBox(height: 28),

          // Contenido simulado
          Container(
            padding: const EdgeInsets.all(18),
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
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: categoryColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _typeIcon(),
                    color: categoryColor,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contenido del recurso',
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Contenido simulado para esta actividad.',
                        style: TextStyle(
                          color: AppTheme.textTertiary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Favorito
          SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () {
                appState.toggleFavorite(resource.id);
              },
              icon: Icon(
                isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              label: Text(
                isFavorite
                    ? 'Quitar de favoritos'
                    : 'Agregar a favoritos',
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: isFavorite
                    ? AppTheme.favorite
                    : AppTheme.textPrimary,
                side: BorderSide(
                  color: isFavorite
                      ? AppTheme.favorite
                      : AppTheme.border,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Completado
          SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: () {
                appState.toggleCompleted(resource.id);
              },
              icon: Icon(
                isCompleted
                    ? Icons.check_circle
                    : Icons.check_circle_outline,
              ),
              label: Text(
                isCompleted
                    ? 'Marcar como pendiente'
                    : 'Marcar como completado',
              ),
              style: FilledButton.styleFrom(
                backgroundColor: isCompleted
                    ? AppTheme.success
                    : AppTheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetadataItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetadataItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppTheme.primary,
          size: 19,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textTertiary,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}