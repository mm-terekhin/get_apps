abstract class AppData {
  const AppData({
    required this.appName,
  });

  final String appName;
}

enum MessengerType {
  whatsApp,
  telegram;

  bool get isWhatsApp => this == whatsApp;

  bool get isTelegram => this == telegram;

  String toText() {
    switch (this) {
      case MessengerType.whatsApp:
        return 'whatsApp';
      case MessengerType.telegram:
        return 'telegram';
    }
  }
}

class AppMessenger extends AppData {
  AppMessenger({
    required super.appName,
    required this.type,
  });

  final MessengerType type;

  factory AppMessenger.fromMap(Map map) {
    final type = _getType(
      map['type'],
    );

    if (type == null) {
      throw ArgumentError('The required type value is missing');
    }

    return AppMessenger(
      appName: map['app_name'],
      type: type,
    );
  }
}

MessengerType? _getType(String? type) {
  switch (type) {
    case 'whatsApp':
      return MessengerType.whatsApp;
    case 'telegram':
      return MessengerType.telegram;
    default:
      return null;
  }
}
