// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sushi_app/provider/counter_model.dart';


//more memory usage without provider
//refreshed the whole screen
class CounterAppWithoutProvider extends StatefulWidget {
  const CounterAppWithoutProvider({super.key});

  @override
  State<CounterAppWithoutProvider> createState() => _CounterAppWithoutProviderState();
}

class _CounterAppWithoutProviderState extends State<CounterAppWithoutProvider> {
  int counter = 0;
  // ignore: non_constant_identifier_names
  void Increment () {
    setState(() {
    counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    debugPrint('build withut provider');
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App without provider'),
      ),
      // ignore: prefer_const_constructors
      body: Center(        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(counter.toString(),
                        style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.bold,
                        ),
                        ),
            
            ElevatedButton(onPressed: (){
              Increment();
            }, child: Text('Increment',
            style: TextStyle(
              fontSize: 50,
              

            ),
            )),
          ],
        ),
      ) ,
    );

  }
}