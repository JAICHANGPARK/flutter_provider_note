import 'package:flutter_provider_note/helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TrainDataProvider with ChangeNotifier {
  final dbHelper = DbSyncDataHelper.instance;
  List<Map<String, dynamic>> trainValue = new List();


  TrainDataProvider(){
    getTrainDataWithDatetime(DateTime.now());
  }

  List<Map<String, dynamic>> get getTrainList => trainValue;

  set initTrainValue(List<Map<String, dynamic>> initData) {
    trainValue = initData;
    notifyListeners();
  }

  void getTrainDataWithDatetime(DateTime selectedDt) async {
    if (trainValue.length > 0) {
      trainValue.clear();
    }
    final allRows = await dbHelper.queryUserTrainDataWithDate(
        't0001', selectedDt.toString());
    allRows.forEach((m) => print(m));
    trainValue.addAll(allRows);
    print('query all rows: ${trainValue.length}');
    notifyListeners();
  }
}
