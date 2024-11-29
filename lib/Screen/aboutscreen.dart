// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sushi_app/components/my_image.dart';

class AboutScreen extends StatelessWidget {
  final String title;
  const AboutScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //leading bagian paling kiri
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),

        //actions bagian paling kanan
        // actions: [IconButton(onPressed: (){
        //   Navigator.pop(context);
        // }, icon: Icon(Icons.arrow_back),
        // color: Colors.white,
        // ),
        // ]        ,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
      child : Column(
        children: [
          MyImage(
            url:
                'https://miro.medium.com/v2/resize:fit:750/1*WLHlVYwLrgipr1YUuQ_Xvg.jpeg',
            isInternet: true,
            // showCaption: true,
          ),
          // MyImage(
          // imgPath: 'assets/images/firefly x astra.png',
          // isInternet: false,
          // ),

          //row 1
          firstRowWidget(),

          //row 2
          secondRowWidget(),

          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: 300,
              margin: const EdgeInsets.only(
                top: 20.0,
                left: 10.0,
                right: 10.0,
                ),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  'flutter b2 d2'
                  ,style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                  ),
              ),
            ),
          )
        ],
      ),
      ),
    );
  }

  firstRowWidget() {
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              for (int i = 0; i < 5; i++)
                Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.only(right: 10.0),
                  width: 150,
                  height: 100,
                  // child: MyImage(
                  //   imgPath: 'assets/images/firefly x astra.png',
                  //   isInternet: false,
                  //   showCaption: false,
                  // ),

                  child: Stack(
                    children: [
                      MyImage(
                        url: 'https://picsum.photos/id/3$i/500/500',
                        isInternet: true,
                      ),
                      // Align(
                      //     alignment: Alignment.topLeft,
                      //     child: Text(
                      //       (i + 1).toString(),
                      //       style: TextStyle(
                      //         color: const Color.fromARGB(255, 225, 228, 222),
                      //         fontSize: 40.0,
                      //         fontWeight: FontWeight.bold,
                      //         fontStyle: FontStyle.italic,
                      //         letterSpacing: 2,
                      //       ),
                      //     ))
                    ],
                  ),
                ),
              for (int i = 0; i < 5; i++)
                Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.only(right: 10.0),
                  width: 150,
                  height: 100,
                  // child: MyImage(
                  //   imgPath: 'assets/images/firefly x astra.png',
                  //   isInternet: false,
                  //   showCaption: false,
                  // ),

                  child: Stack(
                    children: [
                      MyImage(
                        url: 'https://picsum.photos/id/4$i/500/500',
                        isInternet: true,
                      ),
                      // Align(
                      //     alignment: Alignment.topLeft,
                      //     child: Text(
                      //       '3${i + 1}',
                      //       style: TextStyle(
                      //         color: const Color.fromARGB(255, 225, 228, 222),
                      //         fontSize: 40.0,
                      //         fontWeight: FontWeight.bold,
                      //         fontStyle: FontStyle.italic,
                      //         letterSpacing: 2,
                      //       ),
                      //     ))
                    ],
                  ),
                )
            ],
          ),
        );
  }

   secondRowWidget() {
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              for (int i = 0; i < 5; i++)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    // color: Colors.transparent,
                    margin: EdgeInsets.only(right: 10.0),
                    width: 100,
                    height: 100,
                    // child: MyImage(
                    //   imgPath: 'assets/images/firefly x astra.png',
                    //   isInternet: false,
                    //   showCaption: false,
                    // ),
                  
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: MyImage(
                            url: 'https://picsum.photos/id/4$i/500/500',
                            isInternet: true,
                          ),
                        ),
                        // Align(
                        //     alignment: Alignment.topLeft,
                        //     child: Text(
                        //       '4${i + 1}',
                        //       style: TextStyle(
                        //         color: const Color.fromARGB(255, 225, 228, 222),
                        //         fontSize: 40.0,
                        //         fontWeight: FontWeight.bold,
                        //         fontStyle: FontStyle.italic,
                        //         letterSpacing: 2,
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                ),
              for (int i = 0; i < 5; i++)
                Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.only(right: 10.0),
                  width: 150,
                  height: 100,
                  // child: MyImage(
                  //   imgPath: 'assets/images/firefly x astra.png',
                  //   isInternet: false,
                  //   showCaption: false,
                  // ),

                  child: Stack(
                    children: [
                      MyImage(
                        url: 'https://picsum.photos/id/5$i/500/500',
                        isInternet: true,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            (i + 1).toString(),
                            style: TextStyle(
                              color: const Color.fromARGB(255, 225, 228, 222),
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 2,
                            ),
                          ))
                    ],
                  ),
                )
            ],
          ),
        );
  }
}
