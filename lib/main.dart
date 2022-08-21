import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;

void main() {
  runApp(MaterialApp(
    title: 'Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue
    ),
    debugShowCheckedModeBanner: false,
    home: const MyHomePage(),
  ));
}



const name = [
  'Foo',
  'Bar',
  'baz',
  'dio'
];

extension RandomElement<T> on Iterable<T>{
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

abstract class Cubit<State> extends BlocBase<State>{
  Cubit(State initialState):super(initialState);
}

class NamesCubit extends Cubit<String?>{
  NamesCubit():super(null);

  void pickRandomName()=> emit(name.getRandomElement());
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final NamesCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit=NamesCubit();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: StreamBuilder<String?>(
        stream: cubit.stream,
        builder: (context, snapshot) {
          final button = TextButton(
              onPressed: ()=>cubit.pickRandomName(),
              child: const Text('Pick a random name'),
          );
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return button;
            case ConnectionState.waiting:
              return button;
            case ConnectionState.active:
              return Column(
                children: [
                  Text(snapshot.data??''),
                  button
                ],
              );
            case ConnectionState.done:
              return const SizedBox();

          }

        },
      ),

    );
  }
}
