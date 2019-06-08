
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateTimeProvider with ChangeNotifier{

  DateTime selectedDate = DateTime.now();

  DateTime get getNowDateTime => selectedDate;

  set setDateTime(DateTime dt){
    selectedDate = dt;
    notifyListeners();
  }
  void addDate() {
    selectedDate = selectedDate.add(Duration(days: 1));
    notifyListeners();
  }

  void subtractDate() {
    selectedDate = selectedDate.subtract(Duration(days: 1));
    notifyListeners();
  }
}
