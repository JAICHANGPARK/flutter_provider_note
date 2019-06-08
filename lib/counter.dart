import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int _counter;
  Counter(this._counter);

  int get stateCounter => _counter;

  getCounter() => _counter;
  setCounter(int counter) => _counter = counter;

  set incrementalCount(int counter){
      counter++;
      notifyListeners();
  }

  void increment(){
    _counter++;
    notifyListeners();
  }

  void decrement(){
    _counter--;
    notifyListeners();
  }
}