import 'package:flutter/material.dart';
import 'package:gocaff/components/my_receipt.dart';
import 'package:gocaff/pages/menu_page.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderProgressPage extends StatelessWidget {
  const OrderProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 227, 222),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Order in Progress...',
          style: GoogleFonts.aBeeZee(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 71, 50, 35),
          ),
        ),
      ),
      body: Column(
        children: [
          MyReceipt(),
          const Spacer(),
          //Return to home
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuPage(),
                  )),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 101, 53, 16),
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //text
                    Text(
                      "Return to homepage",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // const Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
