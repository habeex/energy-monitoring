enum MeasuringUnit { Watt, Kilowatt }

extension MeasuringUnitExt on MeasuringUnit {
  String get unit => switch (this) {
        MeasuringUnit.Watt => 'W',
        MeasuringUnit.Kilowatt => 'kWh',
      };

  bool get isWatt => this == MeasuringUnit.Watt;
}
