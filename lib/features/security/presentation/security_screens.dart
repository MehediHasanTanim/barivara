import 'package:barivara/app/app_services.dart';
import 'package:barivara/core/security/app_lock_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Locks the app at launch and whenever it leaves the foreground.
class AppLockGate extends ConsumerStatefulWidget {
  const AppLockGate({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate>
    with WidgetsBindingObserver {
  AppLockService? _locks;
  AppLockState? _state;
  bool _locked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
  }

  Future<void> _load() async {
    try {
      final AppLockService locks = AppLockService(
        secureStorage: ref.read(appServicesProvider).secureStorage,
      );
      final AppLockState state = await locks.state();
      if (mounted) {
        setState(() {
          _locks = locks;
          _state = state;
          _locked = state.isEnabled;
        });
      }
    } on Object {
      // Widget-only previews do not provide production infrastructure.
      if (mounted) {
        setState(
          () => _state = const AppLockState(
            mode: AppLockMode.disabled,
            biometricAvailable: false,
          ),
        );
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      if (_state?.isEnabled ?? false) setState(() => _locked = true);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Stack(
      children: <Widget>[
        widget.child,
        if (_locked && _locks != null)
          Positioned.fill(
            child: _UnlockScreen(
              locks: _locks!,
              state: _state!,
              onUnlocked: () => setState(() => _locked = false),
            ),
          ),
      ],
    );
  }
}

class _UnlockScreen extends StatefulWidget {
  const _UnlockScreen({
    required this.locks,
    required this.state,
    required this.onUnlocked,
  });

  final AppLockService locks;
  final AppLockState state;
  final VoidCallback onUnlocked;

  @override
  State<_UnlockScreen> createState() => _UnlockScreenState();
}

class _UnlockScreenState extends State<_UnlockScreen> {
  final TextEditingController _pin = TextEditingController();
  bool _working = false;
  String? _message;

  @override
  void dispose() {
    _pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    child: Material(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.lock_rounded,
                    size: 56,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Bari Vara is locked',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _pin,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    autofocus: !widget.state.biometricAvailable,
                    maxLength: 12,
                    decoration: const InputDecoration(labelText: 'PIN'),
                    onSubmitted: (_) => _unlockPin(),
                  ),
                  if (_message != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _message!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _working ? null : _unlockPin,
                    child: const Text('Unlock with PIN'),
                  ),
                  if (widget.state.mode == AppLockMode.biometric) ...<Widget>[
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: _working ? null : _unlockBiometric,
                      icon: const Icon(Icons.fingerprint_rounded),
                      label: const Text('Use biometric unlock'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Future<void> _unlockPin() async {
    setState(() => _working = true);
    final PinVerification result = await widget.locks.verifyPin(_pin.text);
    if (!mounted) return;
    if (result == PinVerification.accepted) {
      widget.onUnlocked();
      return;
    }
    setState(() {
      _working = false;
      _message = result == PinVerification.throttled
          ? 'Too many attempts. Please wait before trying again.'
          : 'PIN did not match.';
    });
  }

  Future<void> _unlockBiometric() async {
    setState(() => _working = true);
    final bool accepted = await widget.locks.authenticateBiometrics();
    if (!mounted) return;
    if (accepted) {
      widget.onUnlocked();
      return;
    }
    setState(() {
      _working = false;
      _message = 'Biometric unlock was unavailable. Use your PIN instead.';
    });
  }
}

/// Optional app lock controls and a concise local privacy explanation.
class SecuritySettingsScreen extends ConsumerStatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  ConsumerState<SecuritySettingsScreen> createState() =>
      _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState
    extends ConsumerState<SecuritySettingsScreen> {
  late final AppLockService _locks;
  AppLockState? _state;
  bool _working = false;

  @override
  void initState() {
    super.initState();
    _locks = AppLockService(
      secureStorage: ref.read(appServicesProvider).secureStorage,
    );
    _refresh();
  }

  Future<void> _refresh() async {
    final AppLockState state = await _locks.state();
    if (mounted) setState(() => _state = state);
  }

  @override
  Widget build(BuildContext context) {
    final AppLockState? state = _state;
    return Scaffold(
      appBar: AppBar(title: const Text('Security & privacy')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text('App lock', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.lock_outline_rounded),
                  title: Text(
                    state?.isEnabled ?? false
                        ? 'PIN lock enabled'
                        : 'App lock disabled',
                  ),
                  subtitle: const Text(
                    'PIN data is stored as a salted verifier in secure device storage.',
                  ),
                ),
                if (state?.isEnabled ?? false) ...<Widget>[
                  SwitchListTile.adaptive(
                    title: const Text('Biometric unlock'),
                    subtitle: Text(
                      state!.biometricAvailable
                          ? 'Use fingerprint or face unlock, with PIN fallback.'
                          : 'Not available on this device or enrollment changed.',
                    ),
                    value: state.biometricsEnabled,
                    onChanged: _working || !state.biometricAvailable
                        ? null
                        : _setBiometric,
                  ),
                  ListTile(
                    title: const Text('Change PIN'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: _working ? null : _setPin,
                  ),
                  ListTile(
                    title: const Text('Disable app lock'),
                    trailing: const Icon(Icons.lock_open_rounded),
                    onTap: _working ? null : _disable,
                  ),
                ] else
                  ListTile(
                    title: const Text('Set PIN lock'),
                    subtitle: const Text(
                      'Use a 4–12 digit PIN to protect this app.',
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: _working ? null : _setPin,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Privacy', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Bari Vara stores tenant, financial, and repair data on this device. '
                'The core app has no account or cloud backend. Sharing, receipts, CSV files, '
                'and backups are sent only when you choose an export action.',
              ),
            ),
          ),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Backup warning: .bvbackup files are currently unencrypted and can contain tenant information. '
                'Only share them with storage locations and people you trust.',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setPin() async {
    final TextEditingController first = TextEditingController();
    final TextEditingController confirm = TextEditingController();
    bool useBiometrics = _state?.biometricsEnabled ?? false;
    final _PinDialogResult? result = await showDialog<_PinDialogResult>(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setDialogState) =>
            AlertDialog(
              title: const Text('Set PIN lock'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: first,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                    decoration: const InputDecoration(
                      labelText: 'PIN (4–12 digits)',
                    ),
                  ),
                  TextField(
                    controller: confirm,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                    decoration: const InputDecoration(labelText: 'Confirm PIN'),
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Enable biometric unlock when available'),
                    value: useBiometrics,
                    onChanged: (bool value) =>
                        setDialogState(() => useBiometrics = value),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(
                    context,
                    _PinDialogResult(first.text, confirm.text, useBiometrics),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
      ),
    );
    first.dispose();
    confirm.dispose();
    if (result == null) return;
    if (result.pin != result.confirmation) {
      _message('PIN entries did not match.');
      return;
    }
    await _run(
      () => _locks.setPin(result.pin, enableBiometrics: result.biometrics),
    );
  }

  Future<void> _setBiometric(bool enabled) =>
      _run(() => _locks.setBiometricsEnabled(enabled));

  Future<void> _disable() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Disable app lock?'),
        content: const Text(
          'Anyone with this device will be able to open Bari Vara.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Disable'),
          ),
        ],
      ),
    );
    if (confirmed == true) await _run(_locks.disable);
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _working = true);
    try {
      await action();
      await _refresh();
    } on ArgumentError catch (error) {
      _message(error.message?.toString() ?? 'PIN could not be saved.');
    } on Object {
      _message('Security settings could not be saved.');
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  void _message(String value) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    }
  }
}

class _PinDialogResult {
  const _PinDialogResult(this.pin, this.confirmation, this.biometrics);
  final String pin;
  final String confirmation;
  final bool biometrics;
}
