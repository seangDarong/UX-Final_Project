import 'package:flutter/material.dart';
import 'package:ux_final_project/models/station/station_model.dart';

/// A custom marker widget for a station, showing availability and a bike icon.
class StationMarker extends StatelessWidget {
  final Station station;
  final bool isSelected;

  const StationMarker({
    super.key,
    required this.station,
    this.isSelected = false,
  });

  Color get _baseColor =>
      station.hasAvailableBikes ? Colors.green : Colors.black;

  Color get _labelColor =>
      station.hasAvailableBikes ? Colors.white : Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: _baseColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.directions_bike_rounded,
                size: 12,
                color: _labelColor,
              ),
              const SizedBox(width: 3),
              Text(
                '${station.availableBikes}',
                style: TextStyle(
                  color: _labelColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
            ],
          ),
        ),

        /// Pin tail
        CustomPaint(
          size: const Size(12, 8),
          painter: _PinTailPainter(color: _baseColor),
        ),
      ],
    );
  }
}

/// Draws a small downward-pointing triangle (pin tail) below the badge - AI generated
class _PinTailPainter extends CustomPainter {
  final Color color;

  const _PinTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_PinTailPainter oldDelegate) =>
      oldDelegate.color != color;
}