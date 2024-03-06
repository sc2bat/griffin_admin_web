import 'package:admin_web_app/ui/airports/airports_view_model.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/airports/airports_model.dart';

class AirportsScreen extends StatefulWidget {
  const AirportsScreen({super.key});

  @override
  State<AirportsScreen> createState() => _AirportsScreenState();
}

class _AirportsScreenState extends State<AirportsScreen> {
  final filterController = TextEditingController();

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.microtask(() {
      final AirportsViewModel airportsViewModel =
          context.read<AirportsViewModel>();
      airportsViewModel.showAirportsInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AirportsViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('airports'),
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
                      onChanged: viewModel.onChanged,
                    ),
                  ),
                  state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : PaginatedDataTable(
                          sortColumnIndex: state.sortColumnIndex,
                          sortAscending: state.sort,
                          columns: [
                            DataColumn(
                              label: const Text('airportId'),
                              onSort: viewModel.onSort,
                            ),
                            DataColumn(
                              label: const Text('airportCode'),
                              onSort: viewModel.onSort,
                            ),
                            DataColumn(
                              label: const Text('airportName'),
                              onSort: viewModel.onSort,
                            ),
                            const DataColumn(
                              label: Text('latitude'),
                            ),
                            const DataColumn(
                              label: Text('longitude'),
                            ),
                            DataColumn(
                              label: const Text('country'),
                              onSort: viewModel.onSort,
                            )
                          ],
                          source: AirportsDataTableSource(state.airportInfo),
                          rowsPerPage: 10,
                          horizontalMargin: 60,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AirportsDataTableSource extends DataTableSource {
  List<AirportsModel> airportsInfo;

  AirportsDataTableSource(this.airportsInfo);

  @override
  DataRow? getRow(int index) {
    final airport = airportsInfo[index];
    return DataRow(cells: [
      DataCell(Text('${airport.airportId}')),
      DataCell(Text(airport.airportCode)),
      DataCell(Text(airport.airportName)),
      DataCell(Text('${airport.latitude}')),
      DataCell(Text('${airport.longitude}')),
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
