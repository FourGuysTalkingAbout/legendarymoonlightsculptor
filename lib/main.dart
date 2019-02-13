import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();

  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('text form field test'),
        centerTitle: true,
      ),
      body: _buildBody(context),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _getInstanceName,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('text').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text("Connecting...");
        return Container();
      },
    );
  }

  Widget _getInstanceName() {
    return TextFormField(
        controller: myController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'type your instance name',
          labelText: 'instance name',
        ));
  }
}