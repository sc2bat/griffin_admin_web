import 'package:admin_web_app/data/model/airports/airports_model.dart';
import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:admin_web_app/data/repository/airports_repository_impl.dart';
import 'package:admin_web_app/data/repository/flights_repository_impl.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter/material.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  List<FlightsModel> flightsInfo = [];
  List<AirportsModel> airportsInfo = [];
  final flightRepository = FlightsRepositoryImpl();
  final airportsRepository = AirportsRepositoryImpl();
  final departureLocFilter = TextEditingController();
  bool sort = true;
  int? sortColumnIndex;

  Future<void> showFlightsInfo(
      {String? date,
      String? departureTime,
      String? arrivalTime,
      int? departureLoc,
      int? arrivalLoc}) async {
    flightsInfo = await flightRepository.getFlightsList(
        date: date,
        departureTime: departureTime,
        arrivalTime: arrivalTime,
        departureLoc: departureLoc,
        arrivalLoc: arrivalLoc);
    setState(() {});
  }

  Future<void> showAirportsInfo() async {
    airportsInfo = await airportsRepository.getAirportsList();
    setState(() {});
  }

  // Map<String,dynamic>saveToMap ([String? date,String? departureTime, String? arrivalTime, int? departureLoc, int? arrivalLoc]){
  //   Map<String, dynamic> result = {
  //       'departure_date' : date,
  //       'departure_time' : departureTime,
  //       'arrival_time': arrivalTime,
  //       'departure_loc' : departureLoc,
  //       'arrival_loc': arrivalLoc
  //   };
  //       return result;
  // }

  void onSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sort = ascending;
    });

    switch (columnIndex) {
      // case 2:
      //   {
      //     if (ascending) {
      //       flightsInfo.sort((a, b) => a.flightDate.compareTo(b.flightDate));
      //     } else {
      //       flightsInfo.sort((a, b) => b.flightDate.compareTo(a.flightDate));
      //     }
      //   }
      //   break;
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
    // showAirportsInfo();
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text('비행일 : '),
                                  const Expanded(
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
                                  const Text('출발지 : '),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: departureLocFilter,
                                      decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          hintText: 'ICN'),
                                    ),
                                  )),
                                  const Text('도착지 : '),
                                  const Expanded(
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
                              const Row(
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
                          // onPressed: () {
                          //   showFlightsInfo(
                          //       departureLoc:
                          //           int.parse(departureLocFilter.text));
                          // },
                          onPressed: (){},
                          child: const Text('확인'),
                        ),
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
                    source: FlightsDataTableSource(flightsInfo, airportsInfo),
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
  List<FlightsModel> flightsInfo;
  List<AirportsModel> airportsInfo;

  FlightsDataTableSource(this.flightsInfo, this.airportsInfo);

  @override
  DataRow? getRow(int index) {
    final flight = flightsInfo[index];
    final departureName = airportsInfo
        .firstWhere((airport) => airport.airportId == flight.departureLoc);
    final arrivalName = airportsInfo
        .firstWhere((airport) => airport.airportId == flight.arrivalLoc);
    return DataRow(cells: [
      DataCell(Text('${flight.flightId}')),
      DataCell(Text('${flight.airplaneId}')),
      // DataCell(Text(
      //     '${flight.flightDate.substring(0, 4)}.${flight.flightDate.substring(4, 6)}.${flight.flightDate.substring(6)}')),
      const DataCell(Text('0000')),
      DataCell(Text(
          '${flight.departureTime.substring(0, 2)}:${flight.departureTime.substring(2)}')),
      DataCell(Text(
          '${flight.arrivalTime.substring(0, 2)}:${flight.arrivalTime.substring(2)}')),
      DataCell(Text(departureName.airportName)),
      DataCell(Text(arrivalName.airportName)),
      DataCell(Text('${flight.departureLoc}')),
      DataCell(Text('${flight.arrivalLoc}')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => flightsInfo.length;

  @override
  int get selectedRowCount => 0;
}
