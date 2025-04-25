import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gocaff/provider/navigation_provider.dart';
import 'package:gocaff/models/navigation_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  final String currentPage;

  const DrawerWidget({super.key, required this.currentPage});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          color: Color.fromARGB(255, 146, 112, 83),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // const SizedBox(height: 10),
                        buildMenuItem(
                          context,
                          item: NavigationItem.home,
                          text: 'Home',
                          icon: Icons.home,
                        ),
                        buildMenuItem(
                          context,
                          item: NavigationItem.cart,
                          text: 'Cart',
                          icon: Icons.shopping_cart,
                        ),
                        buildMenuItem(
                          context,
                          item: NavigationItem.profile,
                          text: 'Profile',
                          icon: Icons.person,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //logout button
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text(
                    'Logout',
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    signUserOut();
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem(
    BuildContext context, {
    required NavigationItem item,
    required String text,
    required IconData icon,
  }) {
    final provider = Provider.of<NavigationProvider>(context);
    final currentItem = provider.navigationItem;
    final isSelected = item == currentItem;

    final color = Colors.white;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: isSelected,
        selectedTileColor: Colors.white24,
        leading: Icon(icon, color: color),
        title: Text(
          text,
          style: GoogleFonts.aBeeZee(
            color: color,
            fontSize: 20,
          ),
        ),
        onTap: () => selectItem(context, item),
      ),
    );
  }

  void selectItem(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(item);

    //close
    Navigator.pop(context);

    //move to other page
    switch (item) {
      case NavigationItem.home:
        Navigator.pushReplacementNamed(context, '/menupage');
        break;
      case NavigationItem.cart:
        Navigator.pushReplacementNamed(context, '/cartpage');
        break;
      case NavigationItem.profile:
        Navigator.pushReplacementNamed(context, '/profilepage');
        break;
    }
  }
}
