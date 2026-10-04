import 'package:barivara/app/theme/bari_vara_theme.dart';
import 'package:barivara/features/billing/presentation/bills_screens.dart';
import 'package:barivara/features/properties/presentation/property_screens.dart';
import 'package:barivara/features/settings/application/settings_controller.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:barivara/features/settings/presentation/settings_screen.dart';
import 'package:barivara/features/tenants/presentation/tenant_screens.dart';
import 'package:barivara/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Localized Bari Vara application root with immediate settings application.
class BariVaraApp extends ConsumerWidget {
  /// Creates the Bari Vara application root.
  const BariVaraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return MaterialApp(
      title: 'Bari Vara',
      debugShowCheckedModeBanner: false,
      locale: Locale(settings.language.localeCode),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: BariVaraTheme.light(),
      darkTheme: BariVaraTheme.dark(),
      themeMode: _themeMode(settings.theme),
      home: settings.onboardingComplete
          ? const _ApplicationShell()
          : const LanguageSelectionScreen(),
    );
  }
}

class _ApplicationShell extends StatefulWidget {
  const _ApplicationShell();

  @override
  State<_ApplicationShell> createState() => _ApplicationShellState();
}

class _ApplicationShellState extends State<_ApplicationShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final Widget page = switch (_selectedIndex) {
      0 => const _HomeScreen(),
      1 => const TenantListScreen(),
      2 => const BillsDashboardScreen(),
      3 => _PlaceholderScreen(title: text.payments),
      _ => const _MoreScreen(),
    };
    return Scaffold(
      body: page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int value) {
          setState(() => _selectedIndex = value);
        },
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: text.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.people_outline_rounded),
            selectedIcon: const Icon(Icons.people_rounded),
            label: text.tenants,
          ),
          NavigationDestination(
            icon: const Icon(Icons.receipt_long_outlined),
            selectedIcon: const Icon(Icons.receipt_long_rounded),
            label: text.bills,
          ),
          NavigationDestination(
            icon: const Icon(Icons.payments_outlined),
            selectedIcon: const Icon(Icons.payments_rounded),
            label: text.payments,
          ),
          NavigationDestination(
            icon: const Icon(Icons.more_horiz_rounded),
            selectedIcon: const Icon(Icons.more_horiz),
            label: text.more,
          ),
        ],
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(text.appTitle)),
      body: SafeArea(
        top: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Icon(
                      Icons.home_rounded,
                      color: colors.primary,
                      size: 64,
                      semanticLabel: text.appTitle,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  text.appTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  text.appSubtitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  text.offlineRecords,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MoreScreen extends StatelessWidget {
  const _MoreScreen();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(text.more)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Card(
            child: ListTile(
              leading: const Icon(Icons.apartment_rounded),
              title: Text(text.propertiesAndUnits),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const PropertyListScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: Text(text.settings),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(text.comingSoon)),
    );
  }
}

ThemeMode _themeMode(AppThemePreference preference) {
  return switch (preference) {
    AppThemePreference.light => ThemeMode.light,
    AppThemePreference.dark => ThemeMode.dark,
    AppThemePreference.system => ThemeMode.system,
  };
}
