import 'package:flutter/material.dart';
import 'package:get_apps/get_apps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var apps = <AppData>[];
  AppData? telegram;
  AppData? whatsApp;
  final getApps = const GetApps();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Get Apps app"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final appsList = await getApps.getInstalledMessengers();

                  setState(() {
                    apps = appsList;

                    telegram = appsList
                        .where(
                          (element) => element.type.isTelegram,
                        )
                        .firstOrNull;

                    whatsApp = appsList
                        .where(
                          (element) => element.type.isWhatsApp,
                        )
                        .firstOrNull;
                  });
                },
                child: const Text(
                  'Get list apps',
                ),
              ),
              if (whatsApp != null)
                ElevatedButton(
                  onPressed: () async {
                    await getApps.openMessengerApp(
                      type: MessengerType.whatsApp,
                      arg: '7999999999',
                    );
                  },
                  child: const Text(
                    'Open whatsApp',
                  ),
                ),
              if (telegram != null)
                ElevatedButton(
                  onPressed: () async {
                    await getApps.openMessengerApp(
                      type: MessengerType.telegram,
                      arg: 'test',
                    );
                  },
                  child: const Text(
                    'Open telegram',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
