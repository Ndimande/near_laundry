import 'package:flutter/material.dart';
import 'package:near_laundry/models/sign_up.dart';
import 'package:near_laundry/models/user.dart';
import 'package:near_laundry/screens/user_profile.dart';
import 'package:near_laundry/widgets.dart/scrollableWidget.dart';
import 'package:near_laundry/widgets.dart/utils.dart';

import '../models/booking.dart';

class ViewOrdersWidget extends StatelessWidget {
  final List<Booking> list;
  final columns = ['Size', 'Prize', 'Pick Date', 'Pick Time', 'Created At'];

  ViewOrdersWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  Widget bulidDataTable() {
    return DataTable(columns: getColumns(columns), rows: getRow(list));
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(label: Text(column));
    }).toList();
  }

  List<DataRow> getRow(List<Booking> booking) => booking.map((Booking book) {
        final cells = [
          book.busketSize,
          book.prize,
          book.pickUpDate.toString().substring(0, 10),
          book.pickUpTime,
          book.createdAt.toString().substring(0, 10)
        ];
        return DataRow(
            cells: Utils.modelBuilder(cells, (index, cells) {
          return DataCell(Text('$cells'));
        }));
      }).toList();

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Your Orders')),
        backgroundColor: const Color.fromARGB(255, 155, 50, 137),
      ),
      body: Container(
          color: Colors.lightBlue,
          child: ScrollableWidget(child: bulidDataTable())),
    ));
  }
}

class Utils {
  static List<T> modelBuilder<M, T>(
          List<M> models, T Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}
