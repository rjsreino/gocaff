import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gocaff/components/drawer_widget.dart';
import 'package:gocaff/components/text_box.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  //all users
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  //edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: GoogleFonts.aBeeZee(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: GoogleFonts.aBeeZee(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: GoogleFonts.aBeeZee(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //cancel
          TextButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.aBeeZee(),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          //save
          TextButton(
            child: Text(
              'Save',
              style: GoogleFonts.aBeeZee(),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          )
        ],
      ),
    );
    //update in firestore
    if (newValue.trim().length > 0) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: DrawerWidget(currentPage: 'Profile'),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 228, 227, 222),
          elevation: 0,
          title: Text(
            'Profile',
            style: GoogleFonts.aBeeZee(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 71, 50, 35),
            ),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return Container(
                color: const Color.fromARGB(255, 228, 227, 222),
                child: ListView(
                  children: [
                    const SizedBox(height: 50),
                    //profile picture
                    const Icon(Icons.person, size: 72),
                    //user email
                    Text(
                      currentUser.email!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 50),
                    //user details
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        'My details',
                        style: GoogleFonts.aBeeZee(color: Colors.grey[600]),
                      ),
                    ),
                    //username
                    MyTextBox(
                      text: userData['username'],
                      sectionName: 'username',
                      onPressed: () => editField('username'),
                    ),
                    //bio
                    MyTextBox(
                      text: userData['bio'],
                      sectionName: 'bio',
                      onPressed: () => editField('bio'),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error ${snapshot.error}"),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
}
