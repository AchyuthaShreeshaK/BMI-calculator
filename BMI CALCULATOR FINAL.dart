// import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // the controller for the text field associated with "height"
  final _heightController = TextEditingController();

  // the controller for the text field associated with "weight"
  final TextEditingController _weightController = TextEditingController();

  // the controller for the text field associated with "age"

  double? _bmi;
  String message = 'Please enter your height and weight';
  // the message at the beginning

  // ignore: unnecessary_const

  static Color? textcolor;
  // This function is triggered when the user pressess the "Calculate" button
  void _calculate() {
    double? height = double.tryParse(_heightController.value.text);
    double? weight = double.tryParse(_weightController.value.text);
    textcolor;
    message;
    // Check if the inputs are valid
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        message = 'Your height and weigh must be positive numbers';
        textcolor = const Color.fromARGB(255, 36, 100, 250);
      });
      return;
    }

    setState(() {
      _bmi = weight * 10000 / (height * height);
      if (_bmi! < 18.5) {
        message = 'You are underweight';
        textcolor = const Color.fromARGB(255, 7, 181, 255);
      } else if (_bmi! < 25) {
        message = 'Your body is fine';
        textcolor = const Color.fromARGB(255, 63, 238, 95);
      } else if (_bmi! < 30) {
        message = 'You are overweight';
        textcolor = const Color.fromARGB(255, 202, 81, 41);
      } else {
        message = 'You are obese';
        textcolor = const Color.fromARGB(255, 255, 0, 0);
      }
    });
  }

  // This function is triggered when the clear button is pressed
  void _setstate() {
    setState(() {
      _bmi = null;
      _weightController.text = '';
      _heightController.text = '';
      message = 'Please Re-enter your height and weight';
      textcolor = Colors.black;
    });
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: 410,
            height: 600,
            child: Card(
              color: const Color.fromARGB(255, 228, 255, 254),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'BMI Calculator',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 30, 24, 208)),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Height (cm) *',
                      ),
                      controller: _heightController,
                      textInputAction: null,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg) *',
                      ),
                      controller: _weightController,
                      // ignore: unrelated_type_equality_checks
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                // hintText: 'Enter your phone number',
                                labelText: 'Age',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 140,
                            height: 220,
                            child: Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text("Gender: "),
                                  DropdownButton<String>(
                                    items: <String>['Male', 'Female']
                                        .map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        // 'Selected value: $selectedValue';

                                        selectedValue = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: _calculate,
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 41, 140, 239),
                                minimumSize: const Size.fromRadius(21)),
                            child: const Text('Calculate'),
                          ),
                          ElevatedButton(
                            onPressed: _setstate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text("Clear X"),
                          )
                        ],
                      ),
                    ),
                    Card(
                        color: const Color.fromARGB(255, 228, 255, 254),
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                _bmi == null
                                    ? 'No Result'
                                    : _bmi!.toStringAsFixed(2),
                                style:
                                    TextStyle(fontSize: 40, color: textcolor),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // ignore: sized_box_for_whitespace
                              Text(
                                message,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: textcolor),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

//(style: const TextStyle( fontSize: 20, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, textAlign: TextAlign.center,)
