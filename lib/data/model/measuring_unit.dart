enum MeasuringUnit { Watts, Kilowatts }

extension MeasuringUnitExt on MeasuringUnit {
  String get unit => switch (this) {
        MeasuringUnit.Watts => 'W',
        MeasuringUnit.Kilowatts => 'kWh',
      };

  bool get isWatt => this == MeasuringUnit.Watts;
}
