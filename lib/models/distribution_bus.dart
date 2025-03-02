import 'dart:math';
import 'electric_receiver.dart';
import '../utils/helpers.dart';

class DistributionBus {
  final String name;                              // Назва
  final double loadVoltage;                       // Напруга навантаження
  final List<ElectricReceiver> electricReceivers; // Список електричних пристоїв
  final List<DistributionBus> distributionBuses;  // Список розподільних шин

  int quantity;                                   // Кількість ЕП
  double? utilizationFactor;                      // Коефіцієнт використання
  double? powerQuantified;                        // n * Pн
  double? powerUtilizationFactor;                 // n * Pн * Кв
  double? reactivePowerUtilizationFactor;         // n * Pн * Кв * tg
  double? powerQuantifiedSquared;                 // n * Pн * Pн
  double? effectiveQuantity;                      // Ефективна кількість ЕП
  double? activePowerFactor;                      // Pозрахунковий коефіцієнт активної потужності
  double? activeLoad;                             // Pозрахунковий активне навантаження
  double? reactiveLoad;                           // Pозрахунковий реактивне навантаження
  double? totalPower;                             // Повна потужність
  double? calculatedCurrent;                      // Струм

  DistributionBus({
    required this.name,
    required this.loadVoltage,
    this.electricReceivers = const [],
    this.distributionBuses = const [],
    this.quantity = 0,
    this.powerQuantified,
    this.powerUtilizationFactor,
    this.reactivePowerUtilizationFactor,
    this.powerQuantifiedSquared,
  });

  void calculateUnknowns() {
    if (electricReceivers.isNotEmpty && distributionBuses.isEmpty) {
      for (var er in electricReceivers) {
        er.calculateUnknowns();
      }
      quantity = quantity != 0
          ? quantity
          : electricReceivers.fold<int>(0, (sum, er) => sum + er.quantity);
      powerQuantified = powerQuantified ??
          electricReceivers.fold<double>(
              0.0, (double sum, er) => sum + (er.powerQuantified ?? 0.0));
      powerUtilizationFactor = powerUtilizationFactor ??
          electricReceivers.fold<double>(
              0.0, (double sum, er) => sum + (er.powerUtilizationFactor ?? 0.0));
      reactivePowerUtilizationFactor = reactivePowerUtilizationFactor ??
          electricReceivers.fold<double>(
              0.0, (double sum, er) => sum + (er.reactivePowerUtilizationFactor ?? 0.0));
      powerQuantifiedSquared = powerQuantifiedSquared ??
          electricReceivers.fold<double>(
              0.0, (double sum, er) => sum + (er.powerQuantifiedSquared ?? 0.0));

      double pq = powerQuantified ?? 0.0;
      double puf = powerUtilizationFactor ?? 0.0;
      double pqs = powerQuantifiedSquared ?? 0.0;

      utilizationFactor = (pq != 0.0) ? puf / pq : 0.0;
      effectiveQuantity = (pq != 0.0 && pqs != 0.0) ? pow(pq, 2) / pqs : 0.0;
      activePowerFactor = getActivePowerFactor(utilizationFactor!, (effectiveQuantity ?? 0.0).toInt());
      activeLoad = (activePowerFactor != null) ? activePowerFactor! * puf : 0.0;
      reactiveLoad = (reactivePowerUtilizationFactor != null && activePowerFactor != null)
          ? reactivePowerUtilizationFactor! * activePowerFactor!
          : 0.0;
      totalPower = sqrt(pow(activeLoad ?? 0.0, 2) + pow(reactiveLoad ?? 0.0, 2));
      calculatedCurrent = (activeLoad != null) ? activeLoad! / loadVoltage : 0.0;
    } else if (distributionBuses.isNotEmpty) {
      for (var bus in distributionBuses) {
        bus.calculateUnknowns();
      }
      powerQuantified = powerQuantified ??
          distributionBuses.fold<double>(
              0.0, (sum, bus) => sum + (bus.powerQuantified ?? 0.0));
      powerUtilizationFactor = powerUtilizationFactor ??
          distributionBuses.fold<double>(
              0.0, (sum, bus) => sum + (bus.powerUtilizationFactor ?? 0.0));
      reactivePowerUtilizationFactor = reactivePowerUtilizationFactor ??
          distributionBuses.fold<double>(
              0.0, (sum, bus) => sum + (bus.reactivePowerUtilizationFactor ?? 0.0));
      powerQuantifiedSquared = powerQuantifiedSquared ??
          distributionBuses.fold<double>(
              0.0, (sum, bus) => sum + (bus.powerQuantifiedSquared ?? 0.0));

      double pq = powerQuantified ?? 0.0;
      double puf = powerUtilizationFactor ?? 0.0;
      double pqs = powerQuantifiedSquared ?? 0.0;

      utilizationFactor = (pq != 0.0) ? puf / pq : 0.0;
      effectiveQuantity = (pq != 0.0 && pqs != 0.0) ? pow(pq, 2) / pqs : 0.0;
      activePowerFactor = getActivePowerFactor(utilizationFactor!, (effectiveQuantity ?? 0.0).toInt(), true);
      activeLoad = (activePowerFactor != null) ? activePowerFactor! * puf : 0.0;
      reactiveLoad = (reactivePowerUtilizationFactor != null && activePowerFactor != null)
          ? reactivePowerUtilizationFactor! * activePowerFactor!
          : 0.0;
      totalPower = sqrt(pow(activeLoad ?? 0.0, 2) + pow(reactiveLoad ?? 0.0, 2));
      calculatedCurrent = (activeLoad != null) ? activeLoad! / loadVoltage : 0.0;
    }
  }
}
