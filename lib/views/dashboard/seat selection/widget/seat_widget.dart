import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../helpers/assets.dart';
import '../../../../models/seat_model.dart';

class SeatWidget extends StatelessWidget {
  final Seat seat;
  final VoidCallback onTap;

  const SeatWidget({
    super.key,
    required this.seat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color seatColor;
    if (seat.isSelected) {
      seatColor = const Color(0xffCD9D0F);
    } else if (seat.isReserved) {
      seatColor = const Color(0xff61C3F2);
    } else if (seat.isAvailable) {
      seatColor = const Color(0xff8F8F8F);
    } else {
      seatColor = const Color(0xff564CA3);
    }

    return GestureDetector(
      onTap: seat.isAvailable && !seat.isReserved ? onTap : null,
      child: SvgPicture.asset(
        ImageSrc.seatIcon,
        color: seatColor,
        height: 15,
        width: 15,
        fit: BoxFit.contain,
      ),
    );
  }
}

class SeatLegend extends StatelessWidget {
  final Color color;
  final String label;

  const SeatLegend({
    super.key,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: SvgPicture.asset(
            ImageSrc.seatIcon,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}