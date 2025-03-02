import 'package:flutter/material.dart';
import '../services/electric_load_repository.dart';

class ElectricLoadCalculatorPage extends StatefulWidget {
  @override
  _ElectricLoadCalculatorPageState createState() => _ElectricLoadCalculatorPageState();
}

class _ElectricLoadCalculatorPageState extends State<ElectricLoadCalculatorPage> {
  String resultText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Калькулятор електричного навантаження"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ElectricLoadRepository.workshop.calculateUnknowns();
                var bus = ElectricLoadRepository.workshop.distributionBuses.isNotEmpty
                    ? ElectricLoadRepository.workshop.distributionBuses.first
                    : null;
                setState(() {
                  resultText = """1. Для заданого складу ЕП та їх характеристик цехової мережі силове навантаження становитиме:
1.1 Груповий коефіцієнт використання для ШР1=ШР2=ШР3: ${bus?.utilizationFactor ?? 0.0};
1.2 Ефективна кількість ЕП для ШР1=ШР2=ШР3: ${(bus?.effectiveQuantity?.toInt() ?? 0)};
1.3 Розрахунковий коефіцієнт активної потужності для ШР1=ШР2=ШР3: ${bus?.activePowerFactor ?? 0.0};
1.4 Розрахункове активне навантаження для ШР1=ШР2=ШР3: ${bus != null ? bus.activeLoad?.toStringAsFixed(2) : "0.00"} кВт;
1.5 Розрахункове реактивне навантаження для ШР1=ШР2=ШР3: ${bus != null ? bus.reactiveLoad?.toStringAsFixed(2) : "0.00"} квар;
1.6 Повна потужність для ШР1=ШР2=ШР3: ${bus != null ? bus.totalPower?.toStringAsFixed(2) : "0.00"} кВА;
1.7 Розрахунковий груповий струм для ШР1=ШР2=ШР3: ${bus != null ? bus.calculatedCurrent?.toStringAsFixed(2) : "0.00"} A;
1.8 Коефіцієнти використання цеху в цілому: ${ElectricLoadRepository.workshop.utilizationFactor?.toStringAsFixed(2) ?? "0.00"};
1.9 Ефективна кількість ЕП цеху в цілому: ${(ElectricLoadRepository.workshop.effectiveQuantity?.toInt() ?? 0)};
1.10 Розрахунковий коефіцієнт активної потужності цеху в цілому: ${ElectricLoadRepository.workshop.activePowerFactor?.toStringAsFixed(2) ?? "0.00"};
1.11 Розрахункове активне навантаження на шинах 0,38 кВ ТП: ${ElectricLoadRepository.workshop.activeLoad?.toStringAsFixed(2) ?? "0.00"} кВт;
1.12 Розрахункове реактивне навантаження на шинах 0,38 кВ ТП: ${ElectricLoadRepository.workshop.reactiveLoad?.toStringAsFixed(2) ?? "0.00"} квар;
1.13 Повна потужність на шинах 0,38 кВ ТП: ${ElectricLoadRepository.workshop.totalPower?.toStringAsFixed(2) ?? "0.00"} кВА;
1.14 Розрахунковий груповий струм на шинах 0,38 кВ ТП: ${ElectricLoadRepository.workshop.calculatedCurrent?.toStringAsFixed(2) ?? "0.00"} A.
""".trim();
                });
              },
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 48)),
              child: Text("Розрахувати"),
            ),
            SizedBox(height: 16),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}
