import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tentwenty_test/helpers/assets.dart';
import 'package:tentwenty_test/helpers/sized_extention.dart';
import 'package:tentwenty_test/views/dashboard/seat%20selection/seat_selection_screen.dart';

class MovieBookingScreen extends StatelessWidget {
  const MovieBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: const Column(
          children: [
            Text(
              "The King's Man",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "In Theaters December 22, 2021",
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 14,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date selector row
            Text("Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  // Replace with actual dates if needed
                  String date = "${5 + index} Mar";
                  bool isSelected = index == 0;
                  return GestureDetector(
                    onTap: () {
                      // Handle date selection logic here
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.px),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.lightBlue : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        date,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 16),

            // Theater and timing options
            Container(
              height: 26.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildTheaterCard("12:30", "Cinetech + Hall 1", "50\$", "2500 bonus", true),
                  _buildTheaterCard("13:30", "Cinetech + Hall 2", "75\$", "3000 bonus", false),
                  // Add more theater cards as needed
                ],
              ),
            ),

            // "Select Seats" button
            SizedBox(height: 16),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Get.to(SeatSelectionScreen());
                // Handle seat selection here
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(90.w, 8.h),
                maximumSize: Size(90.w, 8.h),
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                "Select Seats",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            20.height,
          ],
        ),
      ),
    );
  }

  // Method to build each theater card
  Widget _buildTheaterCard(String time, String hall, String price, String bonus, bool isSelected) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.lightBlue : Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(time, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(hall, style: TextStyle(fontSize: 14, color: Colors.grey)),
          SizedBox(height: 8),
          Container(
              height: 80,
              width: 150.px, // Replace with actual seating preview image if available
              color: Colors.grey[200],
              child: Center(child: Image.asset(ImageSrc.theater))),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("From $price", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text(bonus, style: TextStyle(fontSize: 14, color: Colors.lightBlue)),
            ],
          ),
        ],
      ),
    );
  }
}
