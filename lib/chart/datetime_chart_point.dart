import 'package:emerge/chart/chart_point.dart';

class DateTimeChartPoint extends ChartPoint {
  final DateTime dateTime;

  DateTimeChartPoint(double x, double y, this.dateTime) : super(x, y);
}
