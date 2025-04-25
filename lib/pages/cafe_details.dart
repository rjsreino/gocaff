import 'package:flutter/material.dart';
import 'package:gocaff/models/cafe.dart';
import 'package:gocaff/models/menu_item.dart';
import 'package:provider/provider.dart';
import 'package:gocaff/models/shop.dart';
import 'package:google_fonts/google_fonts.dart';

class CafeDetailsPage extends StatefulWidget {
  final Cafe cafe;
  const CafeDetailsPage({super.key, required this.cafe});

  @override
  State<CafeDetailsPage> createState() => _CafeDetailsPageState();
}

class _CafeDetailsPageState extends State<CafeDetailsPage> {
  // get menu items
  //quantity
  late Map<MenuItem, int> quantityCount;

  @override
  void initState() {
    super.initState();
    final shop = context.read<Shop>();
    quantityCount = {for (var item in shop.menuItemList) item: 0};
  }

  //decrement quantity for a specific menu item
  void decrementQuantity(MenuItem menuItem) {
    setState(() {
      //can't go below zero
      quantityCount[menuItem] = (quantityCount[menuItem] ?? 0) > 0
          ? (quantityCount[menuItem] ?? 0) - 1
          : 0;
    });
  }

  //increment quantity for a specific menu item
  void incrementQuantity(MenuItem menuItem) {
    setState(() {
      //limit quantity to 99
      quantityCount[menuItem] = (quantityCount[menuItem] ?? 0) < 99
          ? (quantityCount[menuItem] ?? 0) + 1
          : 99;
    });
  }

  //add to cart logic
  void addToCart(MenuItem menuItem) {
    int itemQuantity = quantityCount[menuItem] ?? 0;
    //add to cart only if quantity is greater than 0
    if (itemQuantity > 0) {
      //get access to shop
      final shop = context.read<Shop>();
      //add to cart
      shop.addToCart(menuItem, itemQuantity);
      //successful cart addition prompt
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: const Color.fromARGB(255, 146, 76, 23),
          content: Text(
            "Successfully added to cart!",
            style: GoogleFonts.aBeeZee(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.done, color: Colors.white)),
          ],
        ),
      );
      setState(() {
        quantityCount[menuItem] = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 227, 222),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[900],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Order at ${widget.cafe.name} now!',
          style: GoogleFonts.aBeeZee(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 71, 50, 35),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //cafe header container
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(
              children: [
                //cafe image
                Image.asset(
                  widget.cafe.imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 18),

                //cafe details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cafe.name,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.cafe.address,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[800],
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.cafe.rating,
                            style: GoogleFonts.aBeeZee(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          //menu title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Menu",
              style: GoogleFonts.aBeeZee(
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 10),

          //menu item grid
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8,
              ),
              itemCount: Provider.of<Shop>(context).menuItemList.length,
              itemBuilder: (context, index) {
                final menuItem = Provider.of<Shop>(context).menuItemList[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 15,
                    bottom: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          menuItem.imagePath,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        menuItem.name,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        menuItem.description,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Row(
                        //price and popular tag
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //price
                          Text(
                            '\$${menuItem.price.toStringAsFixed(2)}',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          //popular tag
                          if (menuItem.isPopular)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Text(
                                'Popular',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 11,
                                  color: Colors.green[700],
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          //minus button
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              shape: BoxShape.circle,
                            ),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () => decrementQuantity(menuItem),
                                icon: const Icon(
                                  Icons.remove,
                                  size: 18.0,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                          ),
                          //quanitity count
                          SizedBox(
                            width: 23,
                            child: Center(
                              child: Text(
                                (quantityCount[menuItem] ?? 0).toString(),
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          //plus button
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              shape: BoxShape.circle,
                            ),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () => incrementQuantity(menuItem),
                                icon: const Icon(
                                  Icons.add,
                                  size: 18.0,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          addToCart(menuItem);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 146, 76, 23),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Add to Cart',
                          style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
