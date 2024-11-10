import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tentwenty_test/helpers/assets.dart';
import 'package:tentwenty_test/helpers/sized_extention.dart';
import 'package:tentwenty_test/views/dashboard/seat%20selection/widget/seat_widget.dart';

import '../../../models/seat_model.dart';



class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final List<Seat> seats = List.generate(80, (index) => Seat());

//
  void toggleSeatSelection(int index) {
    setState(() {
      seats[index].isSelected = !seats[index].isSelected;
    });
  }

  int get selectedSeatsCount => seats.where((seat) => seat.isSelected).length;

  double get totalPrice => seats.where((seat) => seat.isSelected).fold(0.0, (sum, seat) => sum + seat.price);

  @override
  void initState() {
    super.initState();
    // Mark some seats as reserved for testing
    seats[5].isReserved = true;
    seats[10].isReserved = true;
    seats[15].isReserved = true;
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Column(
          children: [
            Text(
              "The King's Man",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Text(
              "March 5, 2021 | 12:30 Hall 1",
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Screen Label
            Image.asset(ImageSrc.screen),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'SCREEN',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                childAspectRatio: 1.2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: seats.length,
              itemBuilder: (context, index) {
                return SeatWidget(
                  seat: seats[index],
                  onTap: () => toggleSeatSelection(index),
                );
              },
            ),

            // Seat Legend
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SeatLegend(color: Colors.amber, label: "Selected"),
                  SeatLegend(color: Colors.grey.shade300, label: "Not available  "),
                ],
              ),
            ),
            5.height,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SeatLegend(color: Colors.purple, label: "VIP (150\$)"),
                  SeatLegend(color: Colors.blue, label: "Regular (50 \$)"),
                ],
              ),
            ),

            // Row and Seat Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Chip(
                    label: const Text('4 / 3 row'),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  const Spacer(),
                  const Text(
                    'Total Price',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '\$50',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Proceed to Pay Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Proceed to pay',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            15.height,
          ],
        ),
      ),
    );
  }
}





