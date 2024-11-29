import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sushi_app/Screen/Sushi_app/dashboard.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'TenSushi',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/sushi/pngtree-platter-full-of-sushi-image_2555191.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              )),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              'Original Japanese Food from Japan',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Your Journey to Exquisite Japanese Delicacies Begins Here',
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: CupertinoButton(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(70),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) => Dashboard() ), (route) => false,
                  
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(                            
                            fontSize: 25,
                            ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
