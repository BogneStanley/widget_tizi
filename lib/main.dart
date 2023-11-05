import 'package:flutter/material.dart';
import 'package:widget_tizi/widgets/circular_slider/circular_slider.dart';
import 'package:widget_tizi/widgets/circular_slider/circular_slider_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CircularSliderController controller = CircularSliderController(day: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  try {
                    int.parse(value!);
                    return null;
                  } catch (e) {
                    return 'Please enter a valid day';
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Day',
                ),
                onChanged: (value) {
                  try {
                    controller.changeDay(int.parse(value));
                  } catch (e) {}
                },
              ),
              CircularSlider(
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
