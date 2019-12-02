import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model/Med.dart';
import 'package:flutter_app/dbHelper/DatabaseHelper.dart';

class MedsScreen extends StatefulWidget{
  final Med med;
  MedsScreen(this.med);

  @override
  State<StatefulWidget> createState() => new _MedsScreenState();

}

class _MedsScreenState extends State<MedsScreen> {
  DatabaseHelper db = new DatabaseHelper();

  TextEditingController _nameController;
  TextEditingController _exp_dateController;
  TextEditingController _piecesController;
  TextEditingController _base_substController;
  TextEditingController _quantityController;
  TextEditingController _descriptionController;

  @override
  void initState(){
    super.initState();

    _nameController = new TextEditingController(text: widget.med.name);
    _exp_dateController = new TextEditingController(text: widget.med.expiration_date);
    _piecesController = new TextEditingController(text: widget.med.pieces.toString());
    _base_substController = new TextEditingController(text: widget.med.base_subst);
    _quantityController = new TextEditingController(text: widget.med.quantity);
    _descriptionController = new TextEditingController(text: widget.med.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meds')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              keyboardType: TextInputType.text,
            ),
            Padding(padding: new EdgeInsets.all(3.0)),
            TextField(
              controller: _exp_dateController,
              decoration: InputDecoration(labelText: 'Exp date'),
              keyboardType: TextInputType.text,
            ),
            Padding(padding: new EdgeInsets.all(3.0)),
            TextField(
              controller: _piecesController,
              decoration: InputDecoration(labelText: 'Pieces'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
            ),
            Padding(padding: new EdgeInsets.all(3.0)),
            TextField(
              controller: _base_substController,
              decoration: InputDecoration(labelText: 'Base subst'),
              keyboardType: TextInputType.text,
            ),
            Padding(padding: new EdgeInsets.all(3.0)),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.text,
            ),
            Padding(padding: new EdgeInsets.all(3.0)),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.text,
            ),
            RaisedButton(
              child: (widget.med.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.med.id != null) {
                  Med med = Med(_nameController.text, _exp_dateController.text, int.parse(_piecesController.text.toString()), _base_substController.text, _quantityController.text, _descriptionController.text);
                  db.updateMed(Med.fromMap({
                    'id': widget.med.id,
                    'name': widget.med.name,
                    'exp_date' : widget.med.expiration_date,
                    'pieces' : widget.med.pieces,
                    'base_subst' : widget.med.base_subst,
                    'quantity' : widget.med.quantity,
                    'description' : widget.med.description
                  })).then((_) {
                    Navigator.pop(context, med);
                  });
                } else {
                  Med med = Med(_nameController.text, _exp_dateController.text, int.parse(_piecesController.text.toString()), _base_substController.text, _quantityController.text, _descriptionController.text);
                  db.saveMed(Med(_nameController.text, _exp_dateController.text, int.parse(_piecesController.text.toString()), _base_substController.text, _quantityController.text, _descriptionController.text)).then((_) {
                    Navigator.pop(context, med);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

