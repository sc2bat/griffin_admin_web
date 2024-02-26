import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:admin_web_app/data/repository/flights_repository_impl.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:flutter/material.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  List<FlightsModel> flightsInfo = [];
  final repository = FlightsRepositoryImpl();
  bool sort = true;
  int? sortColumnIndex;

  Future<void> showFlightsInfo() async {
    flightsInfo = await repository.getFlightsList();
    setState(() {});
  }

  void onSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sort = ascending;
    });

    switch (columnIndex) {
      case 2:
        {
          if (ascending) {
            flightsInfo.sort((a, b) => a.flightDate.compareTo(b.flightDate));
          } else {
            flightsInfo.sort((a, b) => b.flightDate.compareTo(a.flightDate));
          }
        }
        break;
      case 3:
        {
          if (ascending) {
            flightsInfo
                .sort((a, b) => a.departureTime.compareTo(b.departureTime));
          } else {
            flightsInfo
                .sort((a, b) => b.departureTime.compareTo(a.departureTime));
          }
        }
        break;
      case 4:
        {
          if (ascending) {
            flightsInfo.sort((a, b) => a.arrivalTime.compareTo(b.arrivalTime));
          } else {
            flightsInfo.sort((a, b) => b.arrivalTime.compareTo(a.arrivalTime));
          }
        }
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    showFlightsInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('flights'),
        ),
        body: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CommonMenuListWidget(context: context),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('비행일 : '),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide()),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide()),
                                        hintText: 'yyyymmdd',
                                      ),
                                    ),
                                  )),
                                  Text('출발지 : '),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          hintText: 'ICN'),
                                    ),
                                  )),
                                  Text('도착지 : '),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          hintText: 'ICN'),
                                    ),
                                  )),
                                  // ElevatedButton(onPressed: () {}, child: Text('확인'))
                                ],
                              ),
                              Row(
                                children: [
                                  Text('출발시간 : '),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          hintText: '1240'),
                                    ),
                                  )),
                                  Text('도착시간 : '),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          hintText: '1240'),
                                    ),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('확인')),
                      )
                    ],
                  ),
                  PaginatedDataTable(
                    sortColumnIndex: sortColumnIndex,
                    sortAscending: sort,
                    columns: [
                      const DataColumn(
                        label: Text('Flight Id'),
                      ),
                      const DataColumn(
                        label: Text('Airplane Id'),
                      ),
                      DataColumn(
                          label: const Text('Flight Date'), onSort: onSort),
                      DataColumn(
                          label: const Text('Departure Time'), onSort: onSort),
                      DataColumn(
                          label: const Text('Arrival Time'), onSort: onSort),
                      const DataColumn(
                        label: Text('Departure Name'),
                      ),
                      const DataColumn(
                        label: Text('Arrival Name'),
                      ),
                    ],
                    source: FlightsDataTableSource(flightsInfo),
                    rowsPerPage: 10,
                    horizontalMargin: 60,
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}

class FlightsDataTableSource extends DataTableSource {
  List<FlightsModel> flightsInfo = [];

  FlightsDataTableSource(this.flightsInfo);

  @override
  DataRow? getRow(int index) {
    final flight = flightsInfo[index];
    return DataRow(cells: [
      DataCell(Text(flight.flightId.toString())),
      DataCell(Text(flight.airplaneId.toString())),
      DataCell(Text(
          '${flight.flightDate.substring(0, 4)}.${flight.flightDate.substring(4, 6)}.${flight.flightDate.substring(6)}')),
      DataCell(Text(
          '${flight.departureTime.substring(0, 2)}:${flight.departureTime.substring(2)}')),
      DataCell(Text(
          '${flight.arrivalTime.substring(0, 2)}:${flight.arrivalTime.substring(2)}')),
      DataCell(Text(flight.departureName)),
      DataCell(Text(flight.arrivalName)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => flightsInfo.length;

  @override
  int get selectedRowCount => 0;
}
