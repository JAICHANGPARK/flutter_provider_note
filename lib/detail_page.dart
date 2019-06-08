import 'package:flutter/material.dart';
import 'package:flutter_provider_note/date_provider.dart';
import 'package:flutter_provider_note/date_util.dart';
import 'package:flutter_provider_note/helper.dart';
import 'package:flutter_provider_note/timelie.dart';
import 'package:flutter_provider_note/train_data_provider.dart';
import 'package:flutter_provider_note/wave_top_bar.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DateTime selectedDatetime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => DateTimeProvider(),
        ),
        ChangeNotifierProvider(
          builder: (context) => TrainDataProvider(),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TopBarWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('훈련 정보',style: TextStyle(
                      fontSize: 18
                    ),),
                    DateSelector(),
                  ],
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 1.8,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.23),
                            blurRadius: 3,
                            spreadRadius: 3)
                      ]),
                  width: MediaQuery.of(context).size.width,
                  child: DataContainer())
            ],
          ),
        ),
//        floatingActionButton: FloatingActionButton(onPressed: () {
//
//          showDatePicker(
//              context: context,
//              initialDate: selectedDatetime,
//              firstDate: DateTime.now().subtract(Duration(days: 720)),
//              lastDate: DateTime.now().add(Duration(days: 360))).then((dt){
//                selectedDatetime = dt;
//
//          });
//        }),
      ),
    );
//    return ChangeNotifierProvider(
//      builder: (context) => DateTimeProvider(),
//      child: Scaffold(
//        body: SingleChildScrollView(
//          child: Column(
//            children: <Widget>[
//              TopBarWidget(),
//            ],
//          ),
//        ),
//      ),
//
//    );
  }
}

class DateSelector extends StatelessWidget {
  DateTime selectedDatetime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final datetime = Provider.of<DateTimeProvider>(context);
    final data = Provider.of<TrainDataProvider>(context);
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        showDatePicker(
                context: context,
                initialDate: selectedDatetime,
                firstDate: DateTime.now().subtract(Duration(days: 720)),
                lastDate: DateTime.now().add(Duration(days: 360)))
            .then((dt) {
          selectedDatetime = dt;
          datetime.setDateTime = selectedDatetime;
          data.getTrainDataWithDatetime(datetime.getNowDateTime);
        });
      },
    );
  }
}

class DataContainer extends StatefulWidget {
  @override
  _DataContainerState createState() => _DataContainerState();
}

class _DataContainerState extends State<DataContainer> {
  final dbHelper = DbSyncDataHelper.instance;

  List<Map<String, dynamic>> trainValue = new List();

  Future<void> getUserTrainData() async {
//    final trainValue = dbHelper.queryUserTrainData(widget.userId);

    final allRows = await dbHelper.queryUserTrainDataWithDate(
        't0001', DateTime.now().toString().split(" ")[0]);
    print('query all rows: ${allRows.length}');
    allRows.forEach((row) => trainValue.add(row));

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserTrainData();
//    final data = Provider.of<TrainDataProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainDataProvider>(
      builder: (BuildContext context, TrainDataProvider value, Widget child) {
        return value.getTrainList.length != 0
            ? ListView.builder(
                itemCount: value.getTrainList.length,
                itemBuilder: (context, index) {
                  return MyTimeLine(value.getTrainList[index]);
//                  return Container(
//                    height: 140,
//                    margin: const EdgeInsets.all(4),
//                    decoration: BoxDecoration(color: Colors.blue),
//                  );
                })
            : Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 16,
                      ),
                      Text("등록된 데이터 없음")
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class TopBarWidget extends StatefulWidget {
  @override
  _TopBarWidgetState createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  final dbHelper = DbSyncDataHelper.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final datetime = Provider.of<DateTimeProvider>(context);
    final data = Provider.of<TrainDataProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Stack(
        children: <Widget>[
          CustomPaint(
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
            ),
            painter: CurveTopBarPainter(),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  onPressed: () async {
                    datetime.subtractDate();
                    print(datetime.selectedDate);
                    data.getTrainDataWithDatetime(datetime.getNowDateTime);
//                    final allRows = await dbHelper.queryUserTrainDataWithDate(
//                        't0001', datetime.selectedDate.toString());
//                    print('query all rows: ${allRows.length}');
                  },
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        formatterDayOfWeek.format(datetime.selectedDate),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Colors.white,
                            letterSpacing: 1.2),
                      ),
                      Text(
                        formatterDate.format(datetime.selectedDate),
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          letterSpacing: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.rotate(
                  angle: 135.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    onPressed: () async {
                      datetime.addDate();
                      print(datetime.selectedDate);
                      data.getTrainDataWithDatetime(datetime.getNowDateTime);
//                      final allRows = await dbHelper.queryUserTrainDataWithDate(
//                          't0001', datetime.selectedDate.toString());
//                      print('query all rows: ${allRows.length}');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



