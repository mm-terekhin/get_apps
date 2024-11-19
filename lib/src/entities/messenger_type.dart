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
