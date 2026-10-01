import 'package:flutter/material.dart';

import '../data/resources.dart';
import '../models/study_resource.dart';

class AppState extends ChangeNotifier {
  final List<StudyResource> resources = List.unmodifiable(studyResources);

  final Set<int> favoriteIds = {};
  final Set<int> completedIds = {};

  String searchText = '';
  String selectedCategory = 'Todas';

  int currentTabIndex = 0;
  int? selectedResourceId;

  AppLifecycleState lifecycleState = AppLifecycleState.resumed;

  String get lifecycleMessage {
    switch (lifecycleState) {
      case AppLifecycleState.resumed:
        return 'La app está activa y visible';
      case AppLifecycleState.inactive:
        return 'La app está inactiva';
      case AppLifecycleState.paused:
        return 'La app está en segundo plano';
      case AppLifecycleState.detached:
        return 'La app está desconectada';
      case AppLifecycleState.hidden:
        return 'La app está oculta';
    }
  }

  List<String> get categories {
    final categorySet = <String>{
      'Todas',
      ...resources.map((resource) => resource.category),
    };

    return categorySet.toList();
  }

  List<StudyResource> get filteredResources {
    final query = searchText.trim().toLowerCase();

    return resources.where((resource) {
      final matchesCategory =
          selectedCategory == 'Todas' ||
          resource.category == selectedCategory;

      if (!matchesCategory) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      return resource.title.toLowerCase().contains(query) ||
          resource.category.toLowerCase().contains(query) ||
          resource.author.toLowerCase().contains(query);
    }).toList();
  }

  List<StudyResource> get favoriteResources {
    return resources
        .where((resource) => favoriteIds.contains(resource.id))
        .toList();
  }

  List<StudyResource> get completedResources {
    return resources
        .where((resource) => completedIds.contains(resource.id))
        .toList();
  }

  int get completedCount => completedIds.length;

  int get pendingCount => resources.length - completedIds.length;

  double get completionPercentage {
    if (resources.isEmpty) {
      return 0;
    }

    return completedIds.length / resources.length;
  }

  bool isFavorite(int resourceId) {
    return favoriteIds.contains(resourceId);
  }

  bool isCompleted(int resourceId) {
    return completedIds.contains(resourceId);
  }

  void toggleFavorite(int resourceId) {
    if (favoriteIds.contains(resourceId)) {
      favoriteIds.remove(resourceId);
    } else {
      favoriteIds.add(resourceId);
    }

    notifyListeners();
  }

  void toggleCompleted(int resourceId) {
    if (completedIds.contains(resourceId)) {
      completedIds.remove(resourceId);
    } else {
      completedIds.add(resourceId);
    }

    notifyListeners();
  }

  void setSearchText(String value) {
    searchText = value;
    notifyListeners();
  }

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void selectResource(int resourceId) {
    selectedResourceId = resourceId;
    notifyListeners();
  }

  void changeTab(int index) {
    currentTabIndex = index;
    notifyListeners();
  }

  void updateLifecycleState(AppLifecycleState state) {
    lifecycleState = state;
    notifyListeners();
  }
}
/*
import 'package:flutter/material.dart';

import '../data/resources.dart';
import '../models/study_resource.dart';

class AppState extends ChangeNotifier {
  final List<StudyResource> resources = studyResources;

  final Set<int> favoriteIds = {};
  final Set<int> completedIds = {};

  String selectedCategory = 'Todas';
  String searchText = '';
  int currentTabIndex = 0;

  int? selectedResourceId;

  AppLifecycleState lifecycleState = AppLifecycleState.resumed;

  final List<AppLifecycleState> lifecycleHistory = [];

  // ------------------------------------------------------------
  // Recursos
  // ------------------------------------------------------------

  List<StudyResource> get filteredResources {
    final query = searchText.trim().toLowerCase();

    return resources.where((resource) {
      final matchesCategory =
          selectedCategory == 'Todas' ||
          resource.category == selectedCategory;

      final matchesSearch =
          query.isEmpty ||
          resource.title.toLowerCase().contains(query) ||
          resource.category.toLowerCase().contains(query) ||
          resource.author.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<String> get categories {
    final values = resources.map((resource) => resource.category).toSet();

    return ['Todas', ...values];
  }

  StudyResource? get selectedResource {
    if (selectedResourceId == null) {
      return null;
    }

    for (final resource in resources) {
      if (resource.id == selectedResourceId) {
        return resource;
      }
    }

    return null;
  }

  // ------------------------------------------------------------
  // Favoritos
  // ------------------------------------------------------------

  bool isFavorite(int resourceId) {
    return favoriteIds.contains(resourceId);
  }

  void toggleFavorite(int resourceId) {
    if (favoriteIds.contains(resourceId)) {
      favoriteIds.remove(resourceId);
    } else {
      favoriteIds.add(resourceId);
    }

    notifyListeners();
  }

  List<StudyResource> get favoriteResources {
    return resources
        .where((resource) => favoriteIds.contains(resource.id))
        .toList();
  }

  // ------------------------------------------------------------
  // Progreso
  // ------------------------------------------------------------

  bool isCompleted(int resourceId) {
    return completedIds.contains(resourceId);
  }

  void toggleCompleted(int resourceId) {
    if (completedIds.contains(resourceId)) {
      completedIds.remove(resourceId);
    } else {
      completedIds.add(resourceId);
    }

    notifyListeners();
  }

  int get completedCount {
    return completedIds.length;
  }

  int get pendingCount {
    return resources.length - completedIds.length;
  }

  double get completionPercentage {
    if (resources.isEmpty) {
      return 0;
    }

    return completedIds.length / resources.length;
  }

  List<StudyResource> get completedResources {
    return resources
        .where((resource) => completedIds.contains(resource.id))
        .toList();
  }

  // ------------------------------------------------------------
  // Búsqueda y filtros
  // ------------------------------------------------------------

  void setSearchText(String value) {
    searchText = value;
    notifyListeners();
  }

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  // ------------------------------------------------------------
  // Recurso seleccionado
  // ------------------------------------------------------------

  void selectResource(int resourceId) {
    selectedResourceId = resourceId;
    notifyListeners();
  }

  // ------------------------------------------------------------
  // Ciclo de vida
  // ------------------------------------------------------------

  void updateLifecycleState(AppLifecycleState state) {
    lifecycleState = state;

    lifecycleHistory.insert(0, state);

    // Mantenemos solamente un historial breve.
    if (lifecycleHistory.length > 10) {
      lifecycleHistory.removeLast();
    }

    notifyListeners();
  }

  String get lifecycleMessage {
    switch (lifecycleState) {
      case AppLifecycleState.resumed:
        return 'La aplicación está activa.';
      case AppLifecycleState.inactive:
        return 'La aplicación está inactiva.';
      case AppLifecycleState.paused:
        return 'La aplicación está en pausa.';
      case AppLifecycleState.detached:
        return 'La aplicación está desconectada.';
      case AppLifecycleState.hidden:
        return 'La aplicación está oculta.';
    }
  }

    void changeTab(int index) {
        currentTabIndex = index;
        notifyListeners();
    }
}
*/