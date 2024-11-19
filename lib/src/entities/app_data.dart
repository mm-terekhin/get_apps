
class AppData {
  const AppData({
    required this.type,
    required this.appName,
  });

  final String appName;
  final String type;

  factory AppData.fromMap(Map<dynamic, dynamic> map) => AppData(
        appName: map['app_name'],
        type: map['type'],
      );
}
