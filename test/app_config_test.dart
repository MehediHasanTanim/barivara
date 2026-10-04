import 'package:barivara/app/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses stable initial local data format versions', () {
    expect(AppConfig.databaseName, 'bari_vara.sqlite');
    expect(AppConfig.databaseVersion, 4);
    expect(AppConfig.backupFormatVersion, 1);
    expect(AppConfig.receiptTemplateVersion, 1);
  });
}
