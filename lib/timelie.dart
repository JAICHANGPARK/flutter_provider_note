import 'package:flutter/material.dart';
import 'package:flutter_provider_note/setting_table_widget.dart';

import 'column_setting.dart';
import 'column_train.dart';

class VerticalSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.symmetric(vertical: 6.0),
        height: 120,
        width: 2.0,
        color: Colors.deepOrange);
  }
}

class MyTimeLine extends StatefulWidget {
  final Map<String, dynamic> snapshot;

  MyTimeLine(this.snapshot);

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<MyTimeLine> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.symmetric(horizontal: 10.0),
      child: new Column(
        children: <Widget>[
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: 42.0,
                child: new Center(
                  child: new Stack(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.only(left: 20.0),
                        child: new VerticalSeparator(),
                      ),
                      new Container(
                        height: 42,
                        width: 42,
                        padding: new EdgeInsets.only(),
                        child: new Icon(Icons.fiber_manual_record,
                            color: Colors.white),
                        decoration: new BoxDecoration(
                            color: new Color(0xff00c6ff),
                            shape: BoxShape.circle),
                      )
                    ],
                  ),
                ),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(left: 20.0, top: 5.0),
                      child: new Text(
                        'Session:${widget.snapshot[TrainingColumn.columnSession]} (Set: ${widget.snapshot[TrainingColumn.columnSet]})',
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrange,
                            fontSize: 16.0),
                      ),
                    ),
                    ExpansionTile(
                      title: new Padding(
                        padding: new EdgeInsets.only(left: 5.0, top: 5.0),
                        child: new Text(
                            '걸음수 : ${widget.snapshot[TrainingColumn.columnTrainStep]} 걸음\n'
                            '이동거리 : ${widget.snapshot[TrainingColumn.columnTrainDistance]}[m]\n'
                            '속도: ${widget.snapshot[TrainingColumn.columnTrainSpeed] / 10} [m/s]'),
                      ),
                      children: <Widget>[
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8),
                          child: Align(alignment: Alignment.centerLeft,child: Text("설정값")),
                        ),
                        Container(
                            height: 240,
                            margin: const EdgeInsets.only(left: 18),
                            child: SettingTableWidget(widget.snapshot)),
                        SizedBox(height: 16,)
//                        DataTable(
//                          columns: <DataColumn>[
//                            DataColumn(label: Text("왼쪽 스윙 고관절")),
//                            DataColumn(label: Text("왼쪽 스윙 슬관절")),
//                          ],
//                          rows: <DataRow>[
//                            DataRow(
//                              cells: <DataCell>[
//                                DataCell(
//                                  Text(
//                                      '${(widget.snapshot[SettingColumn.columnLeftSwing] & 0xF0) >> 4}'),
//                                ),
//                                DataCell(
//                                  Text(
//                                      '${(widget.snapshot[SettingColumn.columnLeftSwing] & 0x0F)}'),
//                                ),
//                              ],
//                            ),
//                          ],
//                        ),
//                        DataTable(
//                          columns: <DataColumn>[
//                            DataColumn(label: Text("오른쪽 스윙 고")),
//                            DataColumn(label: Text("오른쪽 스윙 슬")),
//                          ],
//                          rows: <DataRow>[
//                            DataRow(
//                              cells: <DataCell>[
//                                DataCell(
//                                  Text(
//                                      '${(widget.snapshot[SettingColumn.columnRightSwing] & 0xF0) >> 4}'),
//                                ),
//                                DataCell(
//                                  Text(
//                                      '${(widget.snapshot[SettingColumn.columnRightSwing] & 0x0F)}'),
//                                ),
//                              ],
//                            ),
//                          ],
//                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
