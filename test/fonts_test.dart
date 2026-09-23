import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gps_software/util/app_constant.dart';

/// A wrong path in pubspec's `fonts:` section does not fail the build — the
/// text just silently renders in the platform default font. These tests make
/// that failure loud.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const declared = [
    'assets/fonts/Inter_18pt-Regular.ttf',
    'assets/fonts/Inter_18pt-Medium.ttf',
    'assets/fonts/Inter_18pt-SemiBold.ttf',
    'assets/fonts/Inter_18pt-Bold.ttf',
    'assets/fonts/Inter_18pt-ExtraBold.ttf',
    'assets/fonts/Inter_18pt-Black.ttf',
  ];

  test('every declared Inter weight is bundled', () async {
    final missing = <String>[];
    for (final path in declared) {
      try {
        final data = await rootBundle.load(path);
        if (data.lengthInBytes == 0) missing.add('$path (empty)');
      } catch (_) {
        missing.add(path);
      }
    }
    expect(missing, isEmpty, reason: 'not bundled:\n${missing.join('\n')}');
  });

  test('pubspec declares exactly the Inter files that exist on disk', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final fontBlock = pubspec.substring(pubspec.indexOf('  fonts:'));
    final declaredInPubspec = RegExp(r'asset: (assets/fonts/[^\s]+)')
        .allMatches(fontBlock)
        .map((m) => m.group(1)!)
        .toList();

    expect(declaredInPubspec.toSet(), declared.toSet());
    for (final path in declaredInPubspec) {
      expect(File(path).existsSync(), isTrue, reason: '$path is missing');
    }
  });

  test('the app font constant matches the declared family', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec, contains('- family: ${AppFonts.inter}'));
  });

  test('no widget still asks for the old DMSans family', () {
    final offenders = <String>[];
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        if (entity.readAsStringSync().contains('Dmsans')) {
          offenders.add(entity.path);
        }
      }
    }
    expect(offenders, isEmpty,
        reason: 'still on DMSans:\n${offenders.join('\n')}');
  });
}
