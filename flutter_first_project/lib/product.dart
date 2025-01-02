import 'package:flutter/material.dart';

class Product {
  int _pid;
  String _name;
  String _brand;
  double _qty;
  double _price;
  String _img1;

  Product(
      this._pid, this._name, this._brand, this._qty, this._price, this._img1);

  String get img1 => _img1;

  set img1(String value) {
    _img1 = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  double get qty => _qty;

  set qty(double value) {
    _qty = value;
  }

  String get brand => _brand;

  set brand(String value) {
    _brand = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get pid => _pid;

  set pid(int value) {
    _pid = value;
  }
}