import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/Screen/aboutscreen.dart';
import 'package:sushi_app/Screen/counter_app_noProvider.dart';
import 'package:sushi_app/Screen/counter_app.dart';
import 'package:sushi_app/Screen/emojigen.dart';
import 'package:sushi_app/Screen/homescreen.dart';
import 'package:sushi_app/Screen/Sushi_app/provider/cart.dart';
import 'package:sushi_app/Screen/Sushi_app/provider/counter_model.dart';
import 'package:sushi_app/Screen/product/confirmation.dart';
import 'package:sushi_app/Screen/product/product_screen.dart';
import 'package:sushi_app/Screen/product/order_page.dart';
import 'package:sushi_app/service_provider/service_provider.dart';

import 'service_provider/cart_product_provider.dart';
import 'service_provider/order_provider.dart';
// import 'package:sushi_app/provider/counter_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => Cart()),
         ChangeNotifierProvider(create: (_) => CounterProvider()),
         ChangeNotifierProvider(create: (_) => ServiceProvider()),
         ChangeNotifierProvider(create: (_) => CartProductProvider()),
         ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      
      child: const MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: const Homescreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const Homescreen(),
        '/about': (context) => const AboutScreen(title: 'About Screen'),
        '/EmojiGenerator': (context) => const EmojiGenerator(),
        '/CounterApp': (context) => const CounterApp(),
        '/CounterAppWithoutProv': (context) => const CounterAppWithoutProvider(),
        '/Confirmation': (context) => const ConfirmationPage(),
        '/homeProduct': (context) => const ProductScreen(),
        '/orderHistory': (context) => const OrderPage(),
      },
    
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
} 

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            ),
            IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () {},
            ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
            ),
            IconButton(
            icon: const Icon(Icons.chat_bubble_rounded),
            onPressed: () {},
            )
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
      // This trailing comma makes auto-formatting nicer for build methods.
    bottomNavigationBar: Container(
      color: Colors.blue,
      // height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
        children: [
          const Text('data'),
          const Text('file'),
          const Text('save'),
          Container(
            color: Colors.amber,
            child: const Icon(Icons.search)),
          Container(
            color: Colors.deepOrangeAccent,
            child: const Icon(CupertinoIcons.search))
        ],
      ),
    ),
    );
  }
}
