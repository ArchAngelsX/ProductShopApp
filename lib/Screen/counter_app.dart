import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/provider/counter_model.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App with provider'),
      ),
      // ignore: prefer_const_constructors
      body: Center(        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(builder: (context, value, child) {
              return Text(value.counter.toString(),
            style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
            ),
            );
            },
            ),
            
            ElevatedButton(onPressed: (){
              context.read<CounterProvider>().incrementCounter();
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