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
  int? sortColumnIndex;
  final repository = AirportsRepositoryImpl();
  final filterController = TextEditingController();

  List<AirportsModel> airportsInfo = [];
  List<AirportsModel> filteredData = [];

  Future<void> showAirportsInfo() async {
    airportsInfo = await repository.getAirportsList();
    filteredData = airportsInfo;
    setState(() {});
  }

  @override
  void initState() {
    showAirportsInfo();
    super.initState();
  }

  void onSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sort = ascending;
    });

    switch (columnIndex) {
      case 0:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.airportId.compareTo(b.airportId));
          } else {
            airportsInfo.sort((a, b) => b.airportId.compareTo(a.airportId));
          }
        }
        break;
      case 1:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.airportCode.compareTo(b.airportCode));
          } else {
            airportsInfo.sort((a, b) => b.airportCode.compareTo(a.airportCode));
          }
        }
        break;
      case 2:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.airportName.compareTo(b.airportName));
          } else {
            airportsInfo.sort((a, b) => b.airportName.compareTo(a.airportName));
          }
        }
        break;
      case 3:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.latitude.compareTo(b.latitude));
          } else {
            airportsInfo.sort((a, b) => b.latitude.compareTo(a.latitude));
          }
        }
        break;
      case 4:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.longitude.compareTo(b.longitude));
          } else {
            airportsInfo.sort((a, b) => b.longitude.compareTo(a.longitude));
          }
        }
        break;
      case 5:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.country.compareTo(b.country));
          } else {
            airportsInfo.sort((a, b) => b.country.compareTo(a.country));
          }
        }
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
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
            Padding(
              padding: const EdgeInsets.all(32),
              child: TextField(
                controller: filterController,
                decoration: InputDecoration(
                  hintText: 'airport name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    airportsInfo = filteredData
                        .where((element) => element.airportName.contains(value))
                        .toList();
                  });
                },
              ),
            ),
            PaginatedDataTable(
              sortColumnIndex: sortColumnIndex,
              sortAscending: sort,
              columns: [
                DataColumn(
                  label: const Text('airportId'),
                  onSort: onSort,
                ),
                DataColumn(
                  label: const Text('airportCode'),
                  onSort: onSort,
                ),
                DataColumn(
                  label: const Text('airportName'),
                  onSort: onSort,
                ),
                DataColumn(
                  label: const Text('latitude'),
                  onSort: onSort,
                ),
                DataColumn(
                  label: const Text('longitude'),
                  onSort: onSort,
                ),
                DataColumn(
                  label: const Text('country'),
                  onSort: onSort,
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
