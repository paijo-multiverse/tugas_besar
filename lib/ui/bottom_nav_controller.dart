import 'package:flutter/material.dart';
import 'package:tugas_besar/const/appcolors.dart';
import 'package:tugas_besar/ui/bottom_nav_pages/cart.dart';
import 'package:tugas_besar/ui/bottom_nav_pages/favourite.dart';
import 'package:tugas_besar/ui/bottom_nav_pages/home.dart';
import 'package:tugas_besar/ui/bottom_nav_pages/profile.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [
    const Home(),
    const Favourite(),
    const Cart(),
    const Profile(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "E-Commerce",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home", // Use label instead of title
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Favourite", // Use label instead of title
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: "Cart", // Use label instead of title
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Person", // Use label instead of title
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // ignore: avoid_print
            print(_currentIndex);
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
