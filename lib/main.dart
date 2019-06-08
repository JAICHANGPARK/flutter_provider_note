import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_provider_note/column_setting.dart';
import 'package:flutter_provider_note/column_train.dart';
import 'package:flutter_provider_note/counter.dart';
import 'package:flutter_provider_note/detail_page.dart';
import 'package:flutter_provider_note/helper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DBTestPage(),
//      home: ChangeNotifierProvider<Counter>(
//        builder: (_) => Counter(0),
//        child: HomePage(),
//      ),
    );
  }
}

class DBTestPage extends StatefulWidget {
  @override
  _DBTestPageState createState() => _DBTestPageState();
}

class _DBTestPageState extends State<DBTestPage> {
  DbSyncDataHelper _dbHelper = DbSyncDataHelper.instance;
  List<Map<String, dynamic>> syncSettingDataList = new List();
  List<Map<String, dynamic>> syncTrainDataList = new List();

  void insertData() async {
    String nowTime = DateTime.now().subtract(Duration(days: 2)).toString();
    Random random = new Random();
    for (var i = 0; i < 10; i++) {
      syncTrainDataList.add({
        TrainingColumn.columnPatientId: 't0001',
        TrainingColumn.columnManagerId: 'm0001',
        TrainingColumn.columnTrainIndex: i,
        TrainingColumn.columnSession: i,
        TrainingColumn.columnSet: i,
        SettingColumn.columnLeftSwing: 0x11,
        SettingColumn.columnLeftStance: 0x22,
        SettingColumn.columnRightSwing: 0x11,
        SettingColumn.columnRightStance: 0x33,
        SettingColumn.columnSpeed: 0x22,
        SettingColumn.columnSoundAndControl: 0x32,
        TrainingColumn.columnTrainStep: random.nextInt(200),
        TrainingColumn.columnTrainSpeed: random.nextInt(10),
        TrainingColumn.columnTrainDistance: random.nextInt(300),
        TrainingColumn.columnStartTime: nowTime,
        TrainingColumn.columnEndTime: nowTime,
        TrainingColumn.columnRegisterDate: nowTime,
        TrainingColumn.columnTimestamp:
            DateTime.now().millisecondsSinceEpoch.toString()
      });
      print(i);
    }

    nowTime = DateTime.now().subtract(Duration(days: 1)).toString();
    for (var i = 0; i < 10; i++) {
      syncTrainDataList.add({
        TrainingColumn.columnPatientId: 't0001',
        TrainingColumn.columnManagerId: 'm0001',
        TrainingColumn.columnTrainIndex: i,
        TrainingColumn.columnSession: i,
        TrainingColumn.columnSet: i,
        SettingColumn.columnLeftSwing: 0x22,
        SettingColumn.columnLeftStance: 0x33,
        SettingColumn.columnRightSwing: 0x22,
        SettingColumn.columnRightStance: 0x11,
        SettingColumn.columnSpeed: 0x22,
        SettingColumn.columnSoundAndControl: 32,
        TrainingColumn.columnTrainStep: random.nextInt(200),
        TrainingColumn.columnTrainSpeed: random.nextInt(10),
        TrainingColumn.columnTrainDistance: random.nextInt(300),
        TrainingColumn.columnStartTime: nowTime,
        TrainingColumn.columnEndTime: nowTime,
        TrainingColumn.columnRegisterDate: nowTime,
        TrainingColumn.columnTimestamp:
            DateTime.now().millisecondsSinceEpoch.toString()
      });
      print(i);
    }
    nowTime = DateTime.now().toString();
    for (var i = 0; i < 10; i++) {
      syncTrainDataList.add({
        TrainingColumn.columnPatientId: 't0001',
        TrainingColumn.columnManagerId: 'm0001',
        TrainingColumn.columnTrainIndex: i,
        TrainingColumn.columnSession: i,
        TrainingColumn.columnSet: i,
        SettingColumn.columnLeftSwing: 0x11,
        SettingColumn.columnLeftStance: 0x22,
        SettingColumn.columnRightSwing: 0x33,
        SettingColumn.columnRightStance: 0x11,
        SettingColumn.columnSpeed: 0x22,
        SettingColumn.columnSoundAndControl: 0x32,
        TrainingColumn.columnTrainStep: random.nextInt(200),
        TrainingColumn.columnTrainSpeed: random.nextInt(10),
        TrainingColumn.columnTrainDistance: random.nextInt(300),
        TrainingColumn.columnStartTime: nowTime,
        TrainingColumn.columnEndTime: nowTime,
        TrainingColumn.columnRegisterDate: nowTime,
        TrainingColumn.columnTimestamp:
            DateTime.now().millisecondsSinceEpoch.toString()
      });
      print(i);
    }
    nowTime = DateTime.now().add(Duration(days: 1)).toString();
    for (var i = 0; i < 10; i++) {
      syncTrainDataList.add({
        TrainingColumn.columnPatientId: 't0001',
        TrainingColumn.columnManagerId: 'm0001',
        TrainingColumn.columnTrainIndex: i,
        TrainingColumn.columnSession: i,
        TrainingColumn.columnSet: i,
        SettingColumn.columnLeftSwing: 0x44,
        SettingColumn.columnLeftStance: 0x44,
        SettingColumn.columnRightSwing: 0x44,
        SettingColumn.columnRightStance: 0x11,
        SettingColumn.columnSpeed: 0x22,
        SettingColumn.columnSoundAndControl: 0x32,
        TrainingColumn.columnTrainStep: random.nextInt(200),
        TrainingColumn.columnTrainSpeed: random.nextInt(10),
        TrainingColumn.columnTrainDistance: random.nextInt(300),
        TrainingColumn.columnStartTime: nowTime,
        TrainingColumn.columnEndTime: nowTime,
        TrainingColumn.columnRegisterDate: nowTime,
        TrainingColumn.columnTimestamp:
            DateTime.now().millisecondsSinceEpoch.toString()
      });
      print(i);
    }

    syncTrainDataList.forEach((v) async {
      final id = await _dbHelper.insertTrainData(v);
      print('inserted train row id: $id');
    });
//    syncSettingDataList.clear();
//    syncTrainDataList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.expand_more),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DetailPage();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await _dbHelper.truncateTable();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertData();
        },
        child: Icon(Icons.insert_chart),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    int _counter = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter.stateCounter}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              counter.incrementalCount = counter.stateCounter;
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: counter.decrement,
            tooltip: 'Increment',
            child: Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
