import '../models/electric_receiver.dart';
import '../models/distribution_bus.dart';

class ElectricLoadRepository {
  static final List<ElectricReceiver> electricReceivers = [
    ElectricReceiver(
      name: "Шліфувальний верстат (1–4)",
      nominalEfficiency: 0.92,
      loadPowerFactor: 0.9,
      loadVoltage: 0.38,
      quantity: 4,
      nominalPower: 27.0,
      utilizationFactor: 0.15,
      reactiveCoefficient: 1.33,
    ),
    ElectricReceiver(
      name: "Свердлильний верстат (5–6)",
      nominalEfficiency: 0.92,
      loadPowerFactor: 0.9,
      loadVoltage: 0.38,
      quantity: 2,
      nominalPower: 14.0,
      utilizationFactor: 0.12,
      reactiveCoefficient: 1.0,
    ),
    ElectricReceiver(
      name: "Токарний верстат (9–12)",
      nominalEfficiency: 0.92,
      loadPowerFactor: 0.9,
      loadVoltage: 0.38,
      quantity: 4,
      nominalPower: 42.0,
      utilizationFactor: 0.15,
      reactiveCoefficient: 1.33,
    ),
    ElectricReceiver(
      name: "Циркулярна пила (13)",
      nominalEfficiency: 0.92,
      loadPowerFactor: 0.9,
      loadVoltage: 0.38,
      quantity: 1,
      nominalPower: 36.0,
      utilizationFactor: 0.3,
      reactiveCoefficient: 1.63,
    ),
    ElectricReceiver(
      name: "Прес (16)",
      nominalEfficiency: 0.92,
      loadPowerFactor: 0.9,
      loadVoltage: 0.38,
      quantity: 1,
      nominalPower: 20.0,
      utilizationFactor: 0.5,
      reactiveCoefficient: 0.75,
    ),
    ElectricReceiver(
      name: "Полірувальний верстат (24)",
      nominalEfficiency: 0.92,
      loadPowerFactor: 0.9,
      loadVoltage: 0.38,
      quantity: 1,
      nominalPower: 40.0,
      utilizationFactor: 0.28,
      reactiveCoefficient: 1.0,
    ),
    ElectricReceiver(
      name: "Фрезерний верстат (26-27)",
      nominalEfficiency: 0.92,
      loadPowerFactor: 0.9,
      loadVoltage: 0.38,
      quantity: 2,
      nominalPower: 32.0,
      utilizationFactor: 0.2,
      reactiveCoefficient: 1.0,
    ),
    ElectricReceiver(
      name: "Вентилятор (36)",
      nominalEfficiency: 0.92,
      loadPowerFactor: 0.9,
      loadVoltage: 0.38,
      quantity: 1,
      nominalPower: 20.0,
      utilizationFactor: 0.65,
      reactiveCoefficient: 0.75,
    ),
  ];

  static final List<ElectricReceiver> largeReceivers = [
    ElectricReceiver(
      name: "Зварювальний трансформатор",
      nominalEfficiency: 0.92,
      loadPowerFactor: 0.9,
      loadVoltage: 0.38,
      quantity: 2,
      nominalPower: 100.0,
      utilizationFactor: 0.2,
      reactiveCoefficient: 3.0,
    ),
    ElectricReceiver(
      name: "Сушильна шафа",
      nominalEfficiency: 0.92,
      loadPowerFactor: 0.9,
      loadVoltage: 0.38,
      quantity: 2,
      nominalPower: 120.0,
      utilizationFactor: 0.8,
      reactiveCoefficient: 0.0,
    ),
  ];

  static final List<DistributionBus> distributionBuses = [
    DistributionBus(
      name: "ШР1",
      loadVoltage: 0.38,
      electricReceivers: electricReceivers,
    ),
    DistributionBus(
      name: "ШР2",
      loadVoltage: 0.38,
      electricReceivers: electricReceivers,
    ),
    DistributionBus(
      name: "ШР3",
      loadVoltage: 0.38,
      electricReceivers: electricReceivers,
    ),
  ];

  static final DistributionBus workshop = DistributionBus(
    name: "Цех",
    loadVoltage: 0.38,
    electricReceivers: largeReceivers,
    distributionBuses: distributionBuses,
    quantity: 81,
    powerQuantified: 2330.0,
    powerUtilizationFactor: 752.0,
    reactivePowerUtilizationFactor: 657.0,
    powerQuantifiedSquared: 96399.0,
  );
}
