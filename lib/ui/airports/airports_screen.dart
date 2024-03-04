import 'package:admin_web_app/ui/airports/airports_view_model.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
      airportsViewModel.filterOptionInit();
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
        title: const Center(
          child: Text('GRIFFIN AIRPORT WEB PAGE'),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CommonMenuListWidget(context: context),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: state.filterOptionList
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: state.selectedFilterOption,
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      viewModel.onFilterOption(value);
                                    } else {
                                      logger.info('select error');
                                    }
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextField(
                                  controller: filterController,
                                  decoration: InputDecoration(
                                    hintText: 'Please enter a search keyword',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    suffixIcon: const Icon(Icons.search),
                                  ),
                                  onChanged: (value) =>
                                      viewModel.onFilterChanged(value),
                                  // onChanged: viewModel.onChanged,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PaginatedDataTable(
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
                        source: AirportsDataTableSource(viewModel.airportsInfo),
                        rowsPerPage: 10,
                        horizontalMargin: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
