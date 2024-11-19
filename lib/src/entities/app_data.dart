import 'package:flutter/services.dart';

class AppData {
  const AppData({
    required this.type,
    required this.appName,
    this.version,
    this.icon,
  });

  final String appName;
  final String? version;
  final Uint8List? icon;
  final String type;

  factory AppData.fromMap(Map<dynamic, dynamic> map) => AppData(
        appName: map['app_name'],
        version: map['version'],
        icon: map['icon'],
        type: map['type'],
      );

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write(
        '\nApp name: $appName',
      );

    if (version != null) {
      buffer.write(
        '\nVersion: $version',
      );
    }

    if (icon != null) {
      buffer.write(
        '\nIcon: $icon',
      );
    }

    return buffer.toString();
  }
}
