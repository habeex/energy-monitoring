import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solar_monitor/core/network/network.dart';

final networkProvider = Provider<Network>((ref) {
  return Network();
});
