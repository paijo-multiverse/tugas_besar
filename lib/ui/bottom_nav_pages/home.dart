import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tugas_besar/const/appcolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../product_details_screen.dart';
import '../search_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _carouselImages = [];
  int _dotPosition = 0; // Tipe data _dotPosition diubah menjadi int
  final List _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
      }
    });

    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: "Search products here",
                  hintStyle: TextStyle(fontSize: 15.sp),
                ),
                onTap: () => Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => const SearchScreen())),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            AspectRatio(
              aspectRatio: 3.5,
              child: CarouselSlider(
                
                items: _carouselImages
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(left: 3, right: 3),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(item),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (val, carouselPageChangedReason) {
                    setState(() {
                      _dotPosition = val;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            DotsIndicator(
              dotsCount:
                  _carouselImages.isEmpty ? 1 : _carouselImages.length,
              position: _dotPosition,
              decorator: DotsDecorator(
                activeColor: AppColors.deep_orange,
                color: AppColors.deep_orange.withOpacity(0.5),
                spacing: const EdgeInsets.all(2),
                activeSize: const Size(8, 8),
                size: const Size(6, 6),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2.5,
                ),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                ProductDetails(_products[index]))),
                    child: Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 2,
                            child: Container(
                              color: Colors.yellow,
                              child: Image.network(
                                fit: BoxFit.cover,
                                _products[index]["product-img"][0],
                              ),
                            ),
                          ),
                          Text("${_products[index]["product-name"]}"),
                          Text(
                              _products[index]["product-price"].toString()),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
