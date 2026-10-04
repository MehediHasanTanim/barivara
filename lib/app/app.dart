import 'package:barivara/app/theme/bari_vara_theme.dart';
import 'package:barivara/features/billing/presentation/bills_screens.dart';
import 'package:barivara/features/payments/presentation/payments_screens.dart';
import 'package:barivara/features/properties/presentation/property_screens.dart';
import 'package:barivara/features/repairs/presentation/repairs_screen.dart';
import 'package:barivara/features/reports/presentation/reports_screens.dart';
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
      0 => const DashboardHomeScreen(),
      1 => const TenantListScreen(),
      2 => const BillsDashboardScreen(),
      3 => const PaymentsDuesScreen(),
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
              leading: const Icon(Icons.insights_rounded),
              title: const Text('Reports'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Navigator.of(context).push<void>(
                MaterialPageRoute<void>(builder: (_) => const ReportsScreen()),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.construction_rounded),
              title: Text(text.repairs),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const RepairsScreen(),
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

ThemeMode _themeMode(AppThemePreference preference) {
  return switch (preference) {
    AppThemePreference.light => ThemeMode.light,
    AppThemePreference.dark => ThemeMode.dark,
    AppThemePreference.system => ThemeMode.system,
  };
}
