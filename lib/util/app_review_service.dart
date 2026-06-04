import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppReviewService {
  static final InAppReview _inAppReview = InAppReview.instance;
  static const String _reviewShownKey = 'review_shown_once';
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 12),
      headers: {'User-Agent': 'Mozilla/5.0'},
    ),
  );

  static String normalizeAppStoreId(String iosAppStoreId) =>
      iosAppStoreId.replaceAll('"', '').trim();

  static Future<void> requestReviewAfterAppOpen({
    required String iosAppStoreId,
    Duration delay = const Duration(seconds: 5),
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_reviewShownKey) == true) return;

    await Future.delayed(delay);

    try {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
      } else {
        await _inAppReview.openStoreListing(
          appStoreId:
              Platform.isIOS ? normalizeAppStoreId(iosAppStoreId) : null,
        );
      }
      await prefs.setBool(_reviewShownKey, true);
    } catch (_) {}
  }

  static Future<void> requestReview({String? iosAppStoreId}) async {
    try {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
      } else {
        await openStore(iosAppStoreId: iosAppStoreId);
      }
    } catch (_) {
      await openStore(iosAppStoreId: iosAppStoreId);
    }
  }

  static Future<void> openStore({String? iosAppStoreId}) async {
    await _inAppReview.openStoreListing(
      appStoreId:
          Platform.isIOS ? normalizeAppStoreId(iosAppStoreId ?? '') : null,
    );
  }

  static Future<bool> isPlayStoreAvailable(String packageName) async {
    if (packageName.isEmpty) return false;
    try {
      final response = await _dio.get<String>(
        'https://play.google.com/store/apps/details',
        queryParameters: {'id': packageName, 'hl': 'en'},
        options: Options(
          responseType: ResponseType.plain,
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (response.statusCode != 200) return false;
      final body = (response.data ?? '').toLowerCase();
      return !body.contains("we're sorry") &&
          !body.contains('not found') &&
          !body.contains('item not found');
    } catch (_) {
      return false;
    }
  }

  static bool _itunesLookupHasResults(dynamic decoded) {
    if (decoded is! Map) return false;
    final count = decoded['resultCount'];
    if (count is num && count > 0) return true;
    final results = decoded['results'];
    return results is List && results.isNotEmpty;
  }

  static Future<bool> _itunesLookup(Map<String, String> query) async {
    try {
      final response = await _dio.get<String>(
        'https://itunes.apple.com/lookup',
        queryParameters: query,
        options: Options(
          responseType: ResponseType.plain,
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (response.statusCode != 200) return false;
      final decoded = json.decode(response.data ?? '{}');
      return _itunesLookupHasResults(decoded);
    } catch (_) {
      return false;
    }
  }

  /// App Store listing exists (lookup by app id, then bundle id).
  static Future<bool> isAppStoreAvailable(String iosAppStoreId) async {
    final id = normalizeAppStoreId(iosAppStoreId);
    if (id.isNotEmpty && int.tryParse(id) != null) {
      if (await _itunesLookup({'id': id})) return true;
    }
    try {
      final bundleId = (await PackageInfo.fromPlatform()).packageName;
      if (bundleId.isNotEmpty) {
        return _itunesLookup({'bundleId': bundleId});
      }
    } catch (_) {}
    return false;
  }

  /// Show share only when listed on the current platform's store.
  static Future<bool> shouldShowShareMenu({
    required String iosAppStoreId,
  }) async {
    final storeId = normalizeAppStoreId(iosAppStoreId);
    final packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isIOS) {
      return isAppStoreAvailable(storeId);
    }
    if (Platform.isAndroid) {
      return isPlayStoreAvailable(packageInfo.packageName);
    }

    final playOk = await isPlayStoreAvailable(packageInfo.packageName);
    final iosOk = storeId.isNotEmpty && await isAppStoreAvailable(storeId);
    return playOk || iosOk;
  }

  static String playStoreUrl(String packageName) =>
      'https://play.google.com/store/apps/details?id=$packageName';

  static String appStoreUrl(String iosAppStoreId) =>
      'https://apps.apple.com/app/id${normalizeAppStoreId(iosAppStoreId)}';

  /// Share only the current platform store link (iOS → App Store, Android → Play).
  static Future<void> shareApp({
    required String iosAppStoreId,
    required String appName,
  }) async {
    final storeId = normalizeAppStoreId(iosAppStoreId);
    final packageInfo = await PackageInfo.fromPlatform();
    final lines = <String>['Check out $appName:'];

    if (Platform.isIOS) {
      if (!await isAppStoreAvailable(storeId)) return;
      lines.add(appStoreUrl(storeId));
    } else if (Platform.isAndroid) {
      if (!await isPlayStoreAvailable(packageInfo.packageName)) return;
      lines.add(playStoreUrl(packageInfo.packageName));
    } else {
      if (await isPlayStoreAvailable(packageInfo.packageName)) {
        lines.add('Android: ${playStoreUrl(packageInfo.packageName)}');
      }
      if (storeId.isNotEmpty && await isAppStoreAvailable(storeId)) {
        lines.add('iOS: ${appStoreUrl(storeId)}');
      }
    }

    if (lines.length <= 1) return;

    await Share.share(lines.join('\n'));
  }
}