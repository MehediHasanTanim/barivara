import 'package:barivara/app/app_services.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/settings/data/drift_settings_repository.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The settings supplied by bootstrap, with usable first-run defaults in tests.
final Provider<AppSettingsState> initialAppSettingsProvider =
    Provider<AppSettingsState>((Ref ref) => const AppSettingsState());

/// Stateful application preferences with immediate visual application.
final NotifierProvider<SettingsController, AppSettingsState>
settingsControllerProvider =
    NotifierProvider<SettingsController, AppSettingsState>(
      SettingsController.new,
    );

/// Owns updates to non-financial settings and persists them locally.
class SettingsController extends Notifier<AppSettingsState> {
  @override
  AppSettingsState build() => ref.watch(initialAppSettingsProvider);

  /// Applies [next] immediately, reverting it if database persistence fails.
  Future<Result<void>> update(AppSettingsState next) async {
    final AppSettingsState previous = state;
    state = next;
    final DriftSettingsRepository repository = DriftSettingsRepository(
      ref.read(appServicesProvider).database,
    );
    final Result<void> result = await repository.save(next);
    if (result case Failure<void>()) {
      state = previous;
    }
    return result;
  }
}
