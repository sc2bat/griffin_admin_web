import 'package:admin_web_app/data/model/airports/airports_model.dart';
import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:admin_web_app/ui/flights/flights_view_model.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  final departureLocFilter = TextEditingController();
  final arrivalLocFilter = TextEditingController();

  @override
  void dispose() {
    departureLocFilter.dispose();
    arrivalLocFilter.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.microtask(() {
      final FlightsViewModel flightsViewModel =
          context.read<FlightsViewModel>();
      flightsViewModel.init();
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
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                      items: state.flightOptionYear
                                          .map((int item) =>
                                              DropdownMenuItem<String>(
                                                value: '$item',
                                                child: Text(
                                                  '$item 년',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: '${state.selectedYear}',
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          viewModel
                                              .selectYear(int.parse(value));
                                        } else {
                                          logger.info('year select error');
                                        }
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        height: 40,
                                        width: 140,
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
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
                                      items: state.flightOptionMonth
                                          .map((int item) =>
                                              DropdownMenuItem<String>(
                                                value: '$item',
                                                child: Text(
                                                  '$item 월',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: '${state.selectedMonth}',
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          viewModel
                                              .selectMonth(int.parse(value));
                                        } else {
                                          logger.info('year select error');
                                        }
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        height: 40,
                                        width: 140,
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
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
                                      items: state.flightOptionDay
                                          .map((int item) =>
                                              DropdownMenuItem<String>(
                                                value: '$item',
                                                child: Text(
                                                  '$item 일',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: '${state.selectedDay}',
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          viewModel.selectDay(int.parse(value));
                                        } else {
                                          logger.info('year select error');
                                        }
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        height: 40,
                                        width: 140,
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select departure airport',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: state.airportsName
                                            .map((item) => DropdownMenuItem(
                                                value: item, child: Text(item)))
                                            .toList(),
                                        value: state.selectedDepartureLoc,
                                        onChanged:
                                            viewModel.onChangeDepartureLoc,
                                        dropdownSearchData: DropdownSearchData(
                                          searchInnerWidgetHeight: 50,
                                          searchController: departureLocFilter,
                                          searchInnerWidget: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: departureLocFilter,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Search for a departure airport',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                          searchMatchFn: (item, searchValue) {
                                            return item.value
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                    searchValue.toLowerCase());
                                          },
                                        ),
                                        onMenuStateChange: (isOpen) {
                                          if (!isOpen) {
                                            departureLocFilter.clear();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  const Icon(
                                    Icons.more_horiz,
                                    color: Colors.grey,
                                  ),
                                  const Icon(
                                    Icons.flight_takeoff_outlined,
                                    color: Colors.grey,
                                  ),
                                  const Icon(
                                    Icons.more_horiz,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select arrival airport',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: state.airportsName
                                            .map((item) => DropdownMenuItem(
                                                value: item, child: Text(item)))
                                            .toList(),
                                        value: state.selectedArrivalLoc,
                                        onChanged: viewModel.onChangeArrivalLoc,
                                        dropdownSearchData: DropdownSearchData(
                                          searchInnerWidgetHeight: 50,
                                          searchController: arrivalLocFilter,
                                          searchInnerWidget: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: arrivalLocFilter,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Search for a arrival airport',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                          searchMatchFn: (item, searchValue) {
                                            return item.value
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                    searchValue.toLowerCase());
                                          },
                                        ),
                                        onMenuStateChange: (isOpen) {
                                          if (!isOpen) {
                                            arrivalLocFilter.clear();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      viewModel.resetFlightsInfo();
                                    },
                                    child: const Text('Reset'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      viewModel.showFlightsInfo();
                                    },
                                    child: const Text('Search'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state.flightInfo.isEmpty
                          ? const Text('해당 조건에 맞는 항공편이 없습니다.')
                          : PaginatedDataTable(
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
                                    label: const Text('Flight Date'),
                                    onSort: viewModel.onSort),
                                DataColumn(
                                    label: const Text('Departure Time'),
                                    onSort: viewModel.onSort),
                                DataColumn(
                                    label: const Text('Arrival Time'),
                                    onSort: viewModel.onSort),
                                const DataColumn(
                                  label: Text('Departure Name'),
                                ),
                                const DataColumn(
                                  label: Text('Arrival Name'),
                                ),const DataColumn(
                                  label: Text('Detail'),
                                ),
                              ],
                              source: FlightsDataTableSource(
                                  state.flightInfo, state.airportsInfo,context),
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
  final BuildContext context;
  List<FlightsModel> flightInfo;
  List<AirportsModel> airportsInfo;

  FlightsDataTableSource(this.flightInfo, this.airportsInfo, this.context);

  @override
  DataRow? getRow(int index) {
    final flight = flightInfo[index];
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
      DataCell(IconButton(onPressed: (){context.push('/flights/flightDetail',extra: {'flightsModel': flight});}, icon: const Icon(Icons.remove_red_eye_rounded))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => flightInfo.length;

  @override
  int get selectedRowCount => 0;
}
