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

  Future<void> showFlightsInfo() async {
    flightsInfo = await repository.getFlightsList();
    setState(() {});
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
                  PaginatedDataTable(
                    columns: const [
                      DataColumn(
                        label: Text('Flight Id'),
                      ),
                      DataColumn(
                        label: Text('Airplane Id'),
                      ),
                      DataColumn(
                        label: Text('Flight Date'),
                      ),
                      DataColumn(
                        label: Text('Departure Time'),
                      ),
                      DataColumn(
                        label: Text('Arrival Time'),
                      ),
                      DataColumn(
                        label: Text('Departure Name'),
                      ),
                      DataColumn(
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
