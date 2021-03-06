import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final instanceName = "name2";
final mainCollectionName = "name";

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
    final titleString = 'text form field test';
    return Scaffold(
      appBar: AppBar(
        title: Text(titleString),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Firestore.instance
                  .runTransaction((Transaction transaction) async {
                CollectionReference reference =
                    Firestore.instance.collection(mainCollectionName);

                await reference
                    .add({instanceName: "whats my name 8th time now"});
//                    .document("instance name 2")
//                    .setData({"name": ""});
              });
            },
          )
        ],
      ),
      body: _buildBody(context),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _getInstanceName,
      tooltip: 'create new instance',
      child: Icon(Icons.add),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(mainCollectionName).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return FirestoreListView(documents: snapshot.data.documents);
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

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;

  FirestoreListView({this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 90.0,
      itemBuilder: (BuildContext context, int index) {
        String title = documents[index].data[instanceName].toString();

        return ListTile(
          title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.amber),
              ),
              padding: EdgeInsets.all(5.0),
              child: Row(children: [
                Expanded(
                  child: Text(title),
                )
              ])),
        );
      },
    );
  }
}
