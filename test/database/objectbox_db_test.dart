import 'package:flutter_test/flutter_test.dart';
import 'package:solar_monitor/data/model/monitoring.dart';
import 'package:solar_monitor/objectbox.g.dart';

import 'test_env.dart';

void main() {
  late TestEnv env;
  late Store store;
  late Box<Monitoring> box;

  setUp(() {
    env = TestEnv('box');
    store = env.store;
    box = store.box();
  });

  tearDown(() => env.closeAndDelete());

  test('test put monitoring store box', () {
    final box1 = store.box<Monitoring>();
    expect(box1.isEmpty(), isTrue);
    int putId = box.put(Monitoring(
      timestamp: '2024-02-01',
      value: 1,
      type: 'solar',
    ));
    expect(box1.get(putId)!.timestamp, equals('2024-02-01'));

    // All accesses to a box for a given entity return the same instance.
    expect(box1, equals(store.box<Monitoring>()));
    expect(box1, equals(Box<Monitoring>(store)));
  });

  test('Query with timestamp and solar conditions, and order as desc timestamp',
      () async {
    final monitoring = List.generate(
      10,
      (index) => Monitoring(
        timestamp: '2024-09-08 $index',
        value: index,
        type: 'solar',
      ),
    );

    final monitoring2 = List.generate(
      10,
      (index) => Monitoring(
        timestamp: '2024-09-08 $index',
        value: index,
        type: 'battery',
      ),
    );
    box.putMany([
      ...monitoring,
      Monitoring(timestamp: '2024-08-08', value: 999, type: 'solar'),
      ...monitoring2,
    ]);

    var query = box
        .query(
          Monitoring_.timestamp
              .contains('2024-09-08')
              .and(Monitoring_.type.equals('solar')),
        )
        .order(Monitoring_.timestamp, flags: Order.descending)
        .build();
    try {
      final listDesc = query.find();
      expect(listDesc.map((t) => t.value).toList(),
          [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]);

      final listDescAsync = await query.findAsync();
      expect(listDescAsync.map((t) => t.value).toList(),
          [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]);
    } finally {
      query.close();
    }
  });

  test('Query returns empty list when no matching data', () {
    // Perform a query with conditions that have no match
    var query = box
        .query(
          Monitoring_.timestamp.contains('2025-01-01').and(
                Monitoring_.type.equals('unknown'),
              ),
        )
        .build();

    try {
      final result = query.find();
      expect(result, isEmpty); // Verify the result is empty
    } finally {
      query.close();
    }
  });
}
