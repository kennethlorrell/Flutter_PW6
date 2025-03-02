import 'dart:math';

class ElectricReceiver {
  final String name;                      // Назва
  final double nominalEfficiency;         // Номінальне значення коефіцієнта корисної дії ЕП (nu)
  final double loadPowerFactor;           // Коефіцієнт потужності навантаження (cos φ)
  final double loadVoltage;               // Напруга навантаження (Uн)
  final int quantity;                     // Кількість ЕП (n)
  final double nominalPower;              // Номінальна потужність (Pн)
  final double utilizationFactor;         // Коефіцієнт використання (Kв)
  double reactiveCoefficient;             // Коефіцієнт реактивної потужності (tg φ)

  double? powerQuantified;                // n * Pн
  double? powerUtilizationFactor;         // n * Pн * Кв
  double? reactivePowerUtilizationFactor; // n * Pн * Кв * tg φ
  double? powerQuantifiedSquared;         // n * Pн * Pн
  double? calculatedCurrent;              // Розрахунковий струм

  ElectricReceiver({
    required this.name,
    required this.nominalEfficiency,
    required this.loadPowerFactor,
    required this.loadVoltage,
    required this.quantity,
    required this.nominalPower,
    required this.utilizationFactor,
    required this.reactiveCoefficient,
  });

  void calculateUnknowns() {
    powerQuantified = quantity * nominalPower;
    powerUtilizationFactor = powerQuantified! * utilizationFactor;
    reactivePowerUtilizationFactor = powerUtilizationFactor! * reactiveCoefficient;
    powerQuantifiedSquared = quantity * pow(nominalPower, 2).toDouble();
    calculatedCurrent = powerQuantified! / (sqrt(3) * loadVoltage * loadPowerFactor * nominalEfficiency);
  }
}
