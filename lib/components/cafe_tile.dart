import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/cafe.dart';

class CafeTile extends StatelessWidget {
  final Cafe cafe;
  final void Function()? onTap;

  const CafeTile({
    super.key,
    required this.cafe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //image
              Center(
                child: Image.asset(
                  cafe.imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              //rating and cafe name
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4.0,
                  children: [
                    //cafe name
                    Text(
                      '${cafe.name} ',
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    //rating
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[800],
                          size: 20,
                        ),
                        Text(
                          cafe.rating,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //address
              Text(
                cafe.address,
                softWrap: true,
                overflow: TextOverflow.visible,
                style: GoogleFonts.aBeeZee(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          )),
    );
  }
}
