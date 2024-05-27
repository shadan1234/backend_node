import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:node/features/admin/models/sales.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> earnings;

  const CategoryProductsChart({
    Key? key,
    required this.earnings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: _buildBarGroups(),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 28),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                int index = value.toInt();
                if (index < 0 || index >= earnings.length) return Container();
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 4.0, // Adjust space to prevent labels from intersecting
                  child: Transform.rotate(
                    angle: -0.4, // Rotate labels for better readability
                    child: Text(earnings[index].label),
                  ),
                );
              },
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: Colors.black, // Customize the bottom line color
              width: 1,
            ),
          ),
        ),
        gridData: FlGridData(
          show: false, // Hide grid lines
        ),
        barTouchData: BarTouchData(enabled: true),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return earnings.asMap().entries.map((entry) {
      int index = entry.key;
      Sales sales = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: sales.earning.toDouble(),
            color: Colors.blue,
            width: 16,
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    }).toList();
  }
}
