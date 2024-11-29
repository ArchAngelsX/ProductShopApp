import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/Screen/Sushi_app/cart_sushi.dart';
// import 'package:sushi_app/main.dart';
import 'package:sushi_app/models/menu_sushi.dart';
// import 'package:sushi_app/models/cart_model.dart';
import 'package:sushi_app/provider/cart.dart';

class DetailScreen extends StatefulWidget {
  final Menu food;

  const DetailScreen({
    super.key,
    required this.food,
  });

  @override
  State<DetailScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DetailScreen> {
  int quantityCount = 0;
  int totalPrice = 0;

  void incrementQty() {
    setState(() {
      quantityCount++;
      totalPrice = quantityCount * widget.food.price!;
    });
  }

  void decrementQty() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
        totalPrice = quantityCount * widget.food.price!;
      }
    });
    
    
  }

 bool isHeartFilled = false;

  void _toggleHeart() {
    setState(() {
      isHeartFilled = !isHeartFilled;
    });
  }

 void addToCart() {
      if(quantityCount>0){
        final cart = context.read<Cart>();
        cart.addToCart(widget.food, quantityCount);
        popupDialog();
      }
    }

    void popupDialog(){
      setState(() {
        totalPrice=0;
        quantityCount=0;
      });

      showModalBottomSheet(
        context: context, 
        isDismissible: false,
        showDragHandle: true,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Item Added to Cart',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${widget.food.name} x $quantityCount',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Continue Shopping'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        final cart = context.read<Cart>();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(cartItems: cart.cart)
                          )
                        );
                      },
                      child: Text('Go to Cart'),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      );
    }

    


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<Cart>(
            builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [IconButton(onPressed: (){
                  final cart = context.read<Cart>();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => CartPage(cartItems: cart.cart)));
                }, icon: Icon(CupertinoIcons.cart,size: 30,)
                ),
                
                Consumer<Cart>(
                  builder: (context, cart, child) {
                    return Visibility(
                      visible: cart.itemCount > 0,
                      child: Positioned(
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
                    );
                  }
                )
                ],
                ),
            );
            }
          )
        ],
      ),
      body: menuDetailWidget(context),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: const Color.fromARGB(255, 194, 20, 7),
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // Evenly space the buttons
          children: [
            FloatingActionButton(
              heroTag: 'min',
              backgroundColor: Colors.red.withOpacity(0.4),
              elevation: 0,
              onPressed: () {
                decrementQty();
              },
              child: Icon(Icons.remove, color: Colors.white, size: 30),
            ),
            
            FloatingActionButton(
              heroTag: 'qty',
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: (){},
              child: Text(
                quantityCount.toString()
                
                ,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              
              ),

            FloatingActionButton(
              heroTag: 'plus',
              backgroundColor: Colors.red.withOpacity(0.4),
              elevation: 0,
              onPressed: () {
                incrementQty();
              },
              child: Icon(Icons.add, color: Colors.white, size: 30),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: FloatingActionButton(
                heroTag: 'addCart',
                backgroundColor: Colors.red.withOpacity(0.4),
                onPressed: () {
                  addToCart();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('IDR ${NumberFormat('#,###').format(totalPrice)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                          ),
                          ),
                          Text('Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                          )
                        ],

                      ),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ],
                  ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }

  menuDetailWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Hero(
          tag: widget.food.imgPath.toString(),
          child: Container(
            height: 300,
            width: MediaQuery.sizeOf(context).width,

            // color: const Color.fromARGB(255, 161, 35, 26),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              image: DecorationImage(
                  image: AssetImage(widget.food.imgPath.toString()),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.food.name.toString(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 75, 75, 75),
                    ),
                  ),
                  Text(
                    'IDR ${NumberFormat('#,###').format(widget.food.price)}',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      // Display full stars
                      for (int i = 0; i < widget.food.rating!.floor(); i++)
                        Icon(CupertinoIcons.star_fill,
                            color: Colors.yellow, size: 18),

                      // Display half star if rating is not an integer
                      widget.food.rating != widget.food.rating!.floor()
                          ? Icon(CupertinoIcons.star_lefthalf_fill,
                              color: Colors.yellow, size: 18)
                          : Container(), // empty container if no half star

                      SizedBox(width: 5),
                      Text(
                        widget.food.rating.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 75, 75, 75),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              //icon favorite

              GestureDetector(
                onTap: _toggleHeart,
                child: Icon(
                  isHeartFilled ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.food.description.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
