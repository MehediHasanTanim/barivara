import 'package:barivara/app/app.dart';
import 'package:barivara/app/bootstrap.dart';

/// Starts Bari Vara with the application-level error boundary in place.
void main() {
  bootstrap((_) => const BariVaraApp());
}
