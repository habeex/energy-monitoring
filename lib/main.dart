import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solar_monitor/core/network/url_config.dart';
import 'package:solar_monitor/data/service/local_service.dart';
import 'package:solar_monitor/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UrlConfig.setEnvironment(UrlEnvironment.development); //Server environment
  await LocalService.instance.init(); //Initialise database
  runApp(const ProviderScope(
    child: App(),
  ));
}
