import 'package:admin_web_app/data/model/airports/airports_model.dart';
import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:admin_web_app/ui/flights/flights_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  final departureLocFilter = TextEditingController();

  @override
  void dispose() {
    departureLocFilter.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.microtask(() {
      final FlightsViewModel flightsViewModel =
          context.read<FlightsViewModel>();
      flightsViewModel.showAirportsInfo();
      flightsViewModel.showFlightsInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FlightsViewModel>();
    final state = viewModel.state;
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
                          onPressed: () {},
                          child: const Text('확인'),
                        ),
                      )
                    ],
                  ),
                  PaginatedDataTable(
                    sortColumnIndex: state.sortColumnIndex,
                    sortAscending: state.sort,
                    columns: [
                      const DataColumn(
                        label: Text('Flight Id'),
                      ),
                      const DataColumn(
                        label: Text('Airplane Id'),
                      ),
                      DataColumn(
                          label: const Text('Flight Date'), onSort: viewModel.onSort),
                      DataColumn(
                          label: const Text('Departure Time'), onSort: viewModel.onSort),
                      DataColumn(
                          label: const Text('Arrival Time'), onSort: viewModel.onSort),
                      const DataColumn(
                        label: Text('Departure Name'),
                      ),
                      const DataColumn(
                        label: Text('Arrival Name'),
                      ),
                    ],
                    source: FlightsDataTableSource(viewModel.flightsInfo, state.airportsInfo),
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
      DataCell(Text(
          '${flight.flightDate.substring(0, 4)}.${flight.flightDate.substring(4, 6)}.${flight.flightDate.substring(6)}')),
      // const DataCell(Text('0000')),
      DataCell(Text(
          '${flight.departureTime.substring(0, 2)}:${flight.departureTime.substring(2)}')),
      DataCell(Text(
          '${flight.arrivalTime.substring(0, 2)}:${flight.arrivalTime.substring(2)}')),
      DataCell(Text(departureName.airportName)),
      DataCell(Text(arrivalName.airportName)),
      // DataCell(Text('${flight.departureLoc}')),
      // DataCell(Text('${flight.arrivalLoc}')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => flightsInfo.length;

  @override
  int get selectedRowCount => 0;
}
