import 'package:flutter/material.dart';

import 'screens/catalog_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/home_screen.dart';
import 'screens/progress_screen.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';
import 'widgets/bottom_navigation.dart';


void main() {
  runApp(
    AppStateProvider(
      appState: AppState(),
      child: const ExREApp(),
    ),
  );
}

class AppStateProvider extends InheritedNotifier<AppState> {
  const AppStateProvider({
    super.key,
    required AppState appState,
    required Widget child,
  }) : super(
          notifier: appState,
          child: child,
        );

  static AppState of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<AppStateProvider>();

    assert(provider != null, 'AppStateProvider no encontrado.');

    return provider!.notifier!;
  }
}

class ExREApp extends StatefulWidget {
  const ExREApp({super.key});

  @override
  State<ExREApp> createState() => _ExREAppState();
}

class _ExREAppState extends State<ExREApp>
    with WidgetsBindingObserver {
  //int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final appState = AppStateProvider.of(context);
    appState.updateLifecycleState(state);
  }

  /*
  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  */

  Widget getCurrentScreen(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const CatalogScreen();
      case 2:
        return const GalleryScreen();
      case 3:
        return const FavoritesScreen();
      case 4:
        return const ProgressScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);

    return MaterialApp(
      title: 'ExRE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: Scaffold(
        backgroundColor: const Color(0xFF231C6B),
        body: SafeArea(
          child: getCurrentScreen(appState.currentTabIndex),
        ),
        bottomNavigationBar: ExREBottomNavigation(
          currentIndex: appState.currentTabIndex,
          onTap: appState.changeTab,
        ),
      ),
    );
  }
}