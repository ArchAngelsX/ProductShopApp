import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sushi_app/Screen/Sushi_app/welcome_screen.dart';
import 'package:sushi_app/Screen/aboutscreen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter course 1'),
        backgroundColor: Colors.greenAccent,
        //icon diatas
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       //anonymous route
        //       Navigator.push(
        //         context, MaterialPageRoute(
        //           builder: (context)=> const AboutScreen(
        //            title: 'About Screen',
        //            ),
        //           )
        //           );

        //       //named route
        //       // Navigator.pushNamed(context, '/about');
        //     },
        //     icon: const Icon(CupertinoIcons.info_circle),
        //   )
        // ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15.0
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.blueAccent,
                  )),
              title: Text('anonymous route'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: (){
                Navigator.push(
                context, MaterialPageRoute(
                  builder: (context)=> const AboutScreen(
                   title: 'About Screen',
                   ),
                  )
                  );
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15.0
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.blueAccent,
                  )),
              title: Text('named routes'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: (){
                Navigator.pushNamed(context, '/about');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15.0
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.blueAccent,
                  )),
              title: Text('Emoji Generator'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: (){
                Navigator.pushNamed(context, '/EmojiGenerator');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15.0
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.blueAccent,
                  )),
              title: Text('Counter app with provider'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: (){
                Navigator.pushNamed(context, '/CounterApp');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15.0
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.blueAccent,
                  )),
              title: Text('Counter app with no provider'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: (){
                Navigator.pushNamed(context, '/CounterAppWithoutProv');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15.0
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.blueAccent,
                  )),
              title: Text('SushiApp'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: (){
                Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => WelcomeScreen()),
                   (route) => false
                  );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,   
        padding: EdgeInsets.symmetric(vertical: 10.0),     
        child: Wrap(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Created with Flutter',
                  style:  TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                  SizedBox(
                    width: 10,
                  ),
                  FlutterLogo(
                    size: 20,
                  ),
                  
                ],
              ),
            ),
            // FlutterLogo(),
          ],
        ),
      ),
    );
  }
}
