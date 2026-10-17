import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class HalamanStatistikLayanan extends StatelessWidget {
  const HalamanStatistikLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();
    final data = model.jumlahPerBidang.entries.toList();
    final nilaiMaksimum = data.fold<int>(
      0,
      (maks, item) => item.value > maks ? item.value : maks,
    );
    final maxY = nilaiMaksimum < 4 ? 4.0 : (nilaiMaksimum + 1).toDouble();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ringkasan Pengajuan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Data diperbarui otomatis berdasarkan PengajuanModel.',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _Ringkasan(
                      label: 'Total',
                      value: model.jumlahPengajuan.toString(),
                      color: const Color(0xFF2457C5),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _Ringkasan(
                      label: 'Belum selesai',
                      value: model.jumlahBelumSelesai.toString(),
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _Ringkasan(
                      label: 'Selesai',
                      value: model.jumlahSelesai.toString(),
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 18, 18, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Text(
                  'Pengajuan per Bidang',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 280,
                child: BarChart(
                  BarChartData(
                    maxY: maxY,
                    alignment: BarChartAlignment.spaceAround,
                    gridData: FlGridData(show: true, drawVerticalLine: false),
                    borderData: FlBorderData(show: false),
                    barTouchData: BarTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 1,
                          getTitlesWidget: (value, meta) => Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 48,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index < 0 || index >= data.length)
                              return const SizedBox.shrink();
                            final label = data[index].key;
                            final pendek = label == 'Infrastruktur'
                                ? 'Infra'
                                : label;
                            return SideTitleWidget(
                              meta: meta,
                              space: 8,
                              child: Text(
                                pendek,
                                style: const TextStyle(fontSize: 9),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    barGroups: List.generate(data.length, (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: data[index].value.toDouble(),
                            width: 24,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(5),
                            ),
                            color: const Color(0xFF4779DD),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Buat pengajuan baru untuk melihat perubahan jumlah pada grafik.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Ringkasan extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _Ringkasan({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.09),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    ),
  );
}
