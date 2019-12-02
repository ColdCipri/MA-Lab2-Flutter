import 'package:flutter/foundation.dart';

class Med {
  int _id;
  String _name;
  String _expiration_date;
  int _pieces;
  String _base_subst;
  String _quantity;
  String _description;

  Med(this._name, this._expiration_date, this._pieces, this._base_subst, this._quantity, this._description);

  Med.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._expiration_date = obj['exp_date'];
    this._pieces = obj['pieces'];
    this._base_subst = obj['base_subst'];
    this._quantity = obj['quantity'];
    this._description = obj['description'];
  }

  int get id => _id;
  String get name => _name;
  String get expiration_date => _expiration_date;
  int get pieces => _pieces;
  String get base_subst => _base_subst;
  String get quantity => _quantity;
  String get description => _description;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['exp_date'] = _expiration_date;
    map['pieces'] = _pieces;
    map['base_subst'] = _base_subst;
    map['quantity'] = _quantity;
    map['description'] = _description;

    return map;
  }

  Med.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._expiration_date = map['exp_date'];
    this._pieces = map['pieces'];
    this._base_subst = map['base_subst'];
    this._quantity = map['quantity'];
    this._description = map['description'];
  }
}