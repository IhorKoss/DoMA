import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ihor`s app',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ihor`s app'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _decrementCounter(){
    setState(() {
      _counter=0;
    });
  }
  void _updateText(String newText) {
    setState(() {
      if (newText=='Delete'){
        _counter=0;
      } else{
        final myInt = int.parse(newText);
        _counter = myInt+_counter;
      }

    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You did too many clicks. To be exact:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FormExample(onTextChanged: _updateText),

          ],
        ),
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _decrementCounter,
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
class FormExample extends StatefulWidget {
  final void Function(String) onTextChanged;

  const FormExample({super.key, required this.onTextChanged});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _text='';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter text you want to add',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'You didn`t add any text';
              }
              return null;
            },
            onSaved:(value){
              _text=value!;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onTextChanged(_text);
                }
              },
              child: const Text('Add text'),
            ),
          ),
        ],
      ),
    );
  }
}
