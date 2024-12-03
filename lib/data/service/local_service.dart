import 'package:path/path.dart' as dir;
import 'package:path_provider/path_provider.dart';
import 'package:solar_monitor/data/model/monitoring.dart';
import 'package:solar_monitor/data/model/monitoring_type.dart';
import 'package:solar_monitor/objectbox.g.dart';

class LocalService {
  /// The Store of this app.
  static late Store store;
  static late Box<Monitoring> monitoringBox;

  static LocalService get _instance => LocalService._();
  factory LocalService() => _instance;
  static LocalService get instance => _instance;

  LocalService._();

  /// Create an instance of ObjectBox to use throughout the app.
  Future<void> init() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final storeObject =
        await openStore(directory: dir.join(docsDir.path, "monitoring-app-"));
    store = storeObject;
    monitoringBox = store.box();
  }

  List<int> saveAnalyticsReport(List<Monitoring> monitoring) {
    return monitoringBox.putMany(monitoring);
  }

  List<Monitoring> getAnalyticsReport(String date, MonitorType type) {
    try {
      Query<Monitoring> query = monitoringBox
          .query(Monitoring_.timestamp.contains(date))
          .order(Monitoring_.timestamp)
          .build();
      List<Monitoring> monitoring = query.find();
      query.close();
      return monitoring;
    } catch (e) {
      return [];
    }
  }
}
