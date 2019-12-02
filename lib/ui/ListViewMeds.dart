import 'package:flutter/material.dart';
import 'MedsScreen.dart';
import 'package:flutter_app/model/Med.dart';
import 'package:flutter_app/dbHelper/DatabaseHelper.dart';

class ListViewMeds extends StatefulWidget {
  @override
  _ListViewMedsState createState() => new _ListViewMedsState();
}

class _ListViewMedsState extends State<ListViewMeds> {
  List<Med> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getallMeds().then((meds) {
      setState(() {
        meds.forEach((meds) {
          items.add(Med.fromMap(meds));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meds App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Meds List'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 4.0),
                    ListTile(
                      title: Text(
                        '${items[position].name} ${items[position].pieces}',
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].expiration_date} '
                            '${items[position].base_subst} '
                            '${items[position].quantity} \n'
                            '${items[position].description}',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      isThreeLine: true,
                      leading: Column(
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.edit),
                              color: Colors.pink,
                              onPressed: () => _navigateToMed(context, items[position], position)),
                        ],
                      ),
                      trailing: Column(
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.pinkAccent,
                              onPressed: () => _deleteMed(context, items[position], position)),
                        ],
                      ),
                      //onTap: () => _navigateToMed(context, items[position], position),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewMed(context),
        ),
      ),
    );
  }

  void _deleteMed(BuildContext context, Med med, int position) async {
    db.deleteMed(med.id).then((meds) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToMed(BuildContext context, Med med, int position) async {
    Med result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedsScreen(med)),
    );
    db.getallMeds().then((meds) {
      setState(() {
        items.removeAt(position);
        items.insert(position, result);
      });
    });
  }

  void _createNewMed(BuildContext context) async {
    Med result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedsScreen(Med('', '', 1,'','',''))),
    );

    db.getallMeds().then((destinations) {
      setState(() {
        items.add(result);
      });
    });
  }
}