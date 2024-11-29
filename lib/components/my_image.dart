// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({
    super.key,
    this.url ,
    required this.isInternet,
    this.imgPath,
    // required this.showCaption,
    
    });

   final String? url;
   final String? imgPath;
  //  final bool showCaption ;
   final bool isInternet;
   

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.grey,
          height: 200,
          width: MediaQuery.sizeOf(context).width,

          //internet
          child:Stack(
            children: [
              isInternet == false 
              ? Image.asset(
                imgPath!,
              fit: BoxFit.cover,
              width: MediaQuery.sizeOf(context).width, 
            //   colorBlendMode: BlendMode.darken
            // ,color: Colors.transparent.withOpacity(0.5),
              )
              
              : Image.network(
            width: MediaQuery.sizeOf(context).width,              
            url!,
            fit: BoxFit.cover,
            // colorBlendMode: BlendMode.darken
            // ,color: Colors.transparent.withOpacity(0.5),
          ),
          // showCaption == true  ?
          //  Align(
          //   alignment: Alignment.center,
          //   child: Text(
          //     isInternet == true ? 'image from internet':'image from assets',
          //   style: TextStyle(
          //     color: const Color.fromARGB(255, 225, 228, 222),
          //    fontSize: 20.0,
          //    fontWeight: FontWeight.bold,
          //    fontStyle: FontStyle.italic,
          //    letterSpacing: 2,

          //    ),
          //   )
          
          // )
          // :SizedBox.shrink(),
        
          ],
          ),
          
        );
  }
}