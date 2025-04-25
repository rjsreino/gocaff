import 'package:flutter/material.dart';
import 'package:gocaff/components/drawer_widget.dart';
import 'package:gocaff/models/shop.dart';
import 'package:gocaff/pages/payment_page.dart';
import 'package:provider/provider.dart';
import 'package:gocaff/models/menu_item.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeFromCart(MenuItem menuItem, BuildContext context) {
    //get access to shop
    final shop = context.read<Shop>();

    shop.removeFromCart(menuItem);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 228, 227, 222),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 228, 227, 222),
          elevation: 0,
          title: Text(
            'Cart',
            style: GoogleFonts.aBeeZee(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 71, 50, 35),
            ),
          ),
        ),
        drawer: const DrawerWidget(currentPage: 'cart'),
        body: Column(
          children: [
            //customer cart
            Expanded(
              child: ListView.builder(
                itemCount: value.cart.length,
                itemBuilder: (context, index) {
                  //get item from cart
                  final MenuItem menuItem = value.cart[index];
                  //return list tile
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 207, 191, 185),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: const EdgeInsets.all(5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 227, 218, 214),
                        child: Text(menuItem.name[0]),
                      ),
                      title: Text(
                        menuItem.name,
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //get food price
                      subtitle: Text(menuItem.formattedPrice,
                          style: GoogleFonts.aBeeZee()),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        onPressed: () => removeFromCart(menuItem, context),
                      ),
                    ),
                  );
                },
              ),
            ),
            //pay button
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentPage(),
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
                        "Pay Now",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
