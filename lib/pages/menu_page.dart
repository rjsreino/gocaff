import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gocaff/components/cafe_tile.dart';
import 'package:gocaff/models/cafe.dart';
import 'package:gocaff/pages/cafe_details.dart';
import 'package:gocaff/components/drawer_widget.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  //cafe list
  List cafeList = [
    Cafe(
      name: "Twosome",
      address: "Daeyang AI",
      rating: '4.5',
      imagePath: "lib/images/cafe.png",
    ),
    Cafe(
      name: "Compose",
      address: "KB Bank Sejong Branch",
      rating: '3.9',
      imagePath: "lib/images/cafe.png",
    ),
    Cafe(
      name: "Starbucks",
      address: "Children's Grand Park",
      rating: '4.2',
      imagePath: "lib/images/cafe.png",
    ),
    Cafe(
      name: "Cafe Dictionary Dictionary",
      address: "Gwanggaeto Building",
      rating: '4.7',
      imagePath: "lib/images/cafe.png",
    ),
  ];

  final user = FirebaseAuth.instance.currentUser!;

  //navigate to cafe details
  void navigateToCafeDetails(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CafeDetailsPage(
          cafe: cafeList[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 227, 222),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Hello, ${user.email!}!',
          style: GoogleFonts.aBeeZee(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 71, 50, 35),
          ),
        ),
      ),
      drawer: const DrawerWidget(
        currentPage: 'Home',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //prommos
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 71, 50, 35),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '20% off 1st Order!',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color.fromARGB(255, 71, 50, 35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Redeem',
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'lib/images/coffee-cup.png',
                    height: 80,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //search field
            TextField(
              decoration: InputDecoration(
                hintText: 'Search here...',
                hintStyle: GoogleFonts.aBeeZee(
                  color: Colors.grey[700],
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 71, 50, 35),
                ),
              ),
            ),
            const SizedBox(height: 20),

            //check this cafe out
            Text(
              'Check this cafe out!',
              style: GoogleFonts.aBeeZee(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 71, 50, 35),
              ),
            ),
            const SizedBox(height: 10),

            //addvertised cafe section
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(
                    'lib/images/cafe.png',
                    height: 60,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cafe Dictionary',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 71, 50, 35),
                          ),
                        ),
                        Text(
                          'Gwanggaeto Building',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite_outline,
                      color: Color.fromARGB(255, 71, 50, 35),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //cafe list title
            Text(
              'Cafe List',
              style: GoogleFonts.aBeeZee(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 71, 50, 35),
              ),
            ),
            const SizedBox(height: 10),

            //cafe grid
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1,
                ),
                itemCount: cafeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CafeTile(
                    cafe: cafeList[index],
                    onTap: () => navigateToCafeDetails(index),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
