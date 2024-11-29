import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sushi_app/Screen/Sushi_app/cart_sushi.dart';
import 'package:sushi_app/Screen/Sushi_app/detail_screen.dart';
import 'package:sushi_app/models/menu_sushi.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/provider/cart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Menu> menuList = [];

  Future<void> getMenu() async {
    String dataMenuJson = await rootBundle.loadString('assets/json/food.json');
    List<dynamic> jsonMap = json.decode(dataMenuJson);

    setState(() {
      menuList = jsonMap.map((e) => Menu.fromJson(e)).toList();
    });
  }

  void goToDetailMenu(int index) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => DetailScreen(
        food: menuList[index],
      )
    ));
  }

  @override
  void initState() {
    getMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (menuList.isEmpty) {
      return Center(child: CircularProgressIndicator()); // Show loading indicator
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TenSushi',
              style: TextStyle(fontSize: 23, color: Colors.black),
            ),
            Row(
              children: [
                Icon(
                  CupertinoIcons.placemark,
                  size: 15,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 5),
                Text(
                  'Jakarta, Indonesia',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Consumer<Cart>(
            builder: (context, cart, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    IconButton(
                      icon: Icon(CupertinoIcons.cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(cartItems: cart.cart),
                          ),
                        );
                      },
                    ),
                    if (cart.itemCount > 0)
                      Positioned(
                        top: 2,
                        right: 2,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            cart.itemCount.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //banner promo
          bannerPromoWidget(context),
          SizedBox(height: 25),
          //best seller
          bestSellerWidget(context),
          SizedBox(height: 25),
          //popular food
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 16, 1),
            child: Text('Popular Food',
              style: TextStyle(
                color: Colors.black,
                fontSize: 21,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          popularFoodWidget(),
        ],
      ),
    );
  }

  popularFoodWidget() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: menuList.length,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              goToDetailMenu(index);
            },
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(right: 16),
              height: 160,
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: menuList[index].imgPath.toString(),
                    child: Container(
                      height: 120,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(menuList[index].imgPath.toString()),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3),
                            BlendMode.darken,
                          )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    menuList[index].name.toString(),
                    style: TextStyle(
                      color: const Color.fromARGB(255, 107, 107, 107),
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                    maxLines: 1, // Limit the text to one line
                    overflow: TextOverflow.ellipsis, // Add ellipsis if the text overflows
                  ),
                  Text(
                    'IDR ${NumberFormat('#,###').format(menuList[index].price)}',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Row(
                    children: [
                      Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 14),
                      SizedBox(width: 5),
                      Text(
                        menuList[index].rating.toString(),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 3, 3, 3),
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bestSellerWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Best Seller',
            style: TextStyle(
              fontSize: 21, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              goToDetailMenu(4);
            },
            child: Container(
              height: 200,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage(menuList[4].imgPath.toString()),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  )
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    title: Text(
                      menuList[4].name.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'IDR ${NumberFormat('#,###').format(menuList[4].price)}',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bannerPromoWidget(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: AssetImage(
              'assets/images/sushi/food-still-life-sushi-wallpaper-preview.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          )
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              'Get 59% Off ',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'at Sunday Evening',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            trailing: Icon(
              CupertinoIcons.arrow_right,
              color: Colors.white,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}
