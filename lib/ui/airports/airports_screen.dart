import 'package:admin_web_app/data/repository/airports_repository_impl.dart';
import 'package:flutter/material.dart';
import '../../data/model/airports_model.dart';

class AirportsScreen extends StatefulWidget {
  const AirportsScreen({super.key});

  @override
  State<AirportsScreen> createState() => _AirportsScreenState();
}

class _AirportsScreenState extends State<AirportsScreen> {
  bool sort = true;
  final repository = AirportsRepositoryImpl();

  List<AirportsModel> airportsInfo = [];

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        airportsInfo.sort((a, b) => a.airportId.compareTo(b.airportId));
      } else {
        airportsInfo.sort((a, b) => b.airportId.compareTo(a.airportId));
      }
    }
  }

  Future<void> showAirportsInfo() async {
    airportsInfo = await repository.getAirportsList();
    setState(() {});
    print(airportsInfo);
  }

  @override
  void initState() {
    showAirportsInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('airports'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PaginatedDataTable(
              sortColumnIndex: 0,
              sortAscending: sort,
              columns: [
                DataColumn(
                  label: Text('airportId'),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sort = !sort;
                    });
                    onSortColumn(columnIndex, ascending);
                  },
                ),
                DataColumn(
                  label: Text('airportCode'),
                ),
                DataColumn(
                  label: Text('airportName'),

                ),
                DataColumn(
                  label: Text('latitude'),
                ),
                DataColumn(
                  label: Text('longitude'),
                ),
                DataColumn(
                  label: Text('country'),
                )
              ],
              source: AirportsDataSource(airportsInfo),
              rowsPerPage: 10,
              horizontalMargin: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class AirportsDataSource extends DataTableSource {
  List<AirportsModel> airportsInfo = [];

  AirportsDataSource(this.airportsInfo);

  @override
  DataRow? getRow(int index) {
    final airport = airportsInfo[index];
    return DataRow(cells: [
      DataCell(Text(airport.airportId)),
      DataCell(Text(airport.airportCode)),
      DataCell(Text(airport.airportName)),
      DataCell(Text(airport.latitude)),
      DataCell(Text(airport.longitude)),
      DataCell(Text(airport.country)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => airportsInfo.length;

  @override
  int get selectedRowCount => 0;
}
