import 'package:admin_web_app/data/model/airports/airports_model.dart';
import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:admin_web_app/ui/flights/detail/flight_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightDetailScreen extends StatefulWidget {
  const FlightDetailScreen({
    super.key,
    required this.flightsModel,
    required this.departureAirportModel,
    required this.arrivalAirportModel,
  });

  final FlightsModel flightsModel;
  final AirportsModel departureAirportModel;
  final AirportsModel arrivalAirportModel;

  @override
  State<FlightDetailScreen> createState() => _FlightDetailScreenState();
}

class _FlightDetailScreenState extends State<FlightDetailScreen> {


  @override
  void initState() {
    Future.microtask(() {
      final FlightDetailViewModel flightDetailViewModel =
      context.read<FlightDetailViewModel>();
      final state = flightDetailViewModel.state;
      flightDetailViewModel.init();
      for(int i = 0; i<state.classSeats.length;i++){flightDetailViewModel.getRemainSeats(
            state.airplanesList
                .firstWhere(
                    (e) => e.airplaneId == widget.flightsModel.airplaneId)
                .firstClassSeat,
            state.airplanesList
                .firstWhere(
                    (e) => e.airplaneId == widget.flightsModel.airplaneId)
                .businessClassSeat,
            state.airplanesList
                .firstWhere(
                    (e) => e.airplaneId == widget.flightsModel.airplaneId)
                .economyClassSeat,
            state.classSeats[i]);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FlightDetailViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Detail'),
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CommonMenuListWidget(context: context),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(75.0),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFfbf2ff)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: state.isLoading
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Flight ID : ${widget.flightsModel.flightId}'),
                      Text(
                          'Flight Date : ${widget.flightsModel.flightDate
                              .substring(0, 4)}.${widget.flightsModel.flightDate
                              .substring(4, 6)}.${widget.flightsModel.flightDate
                              .substring(6)}'),
                      SizedBox(
                          height:
                          MediaQuery
                              .of(context)
                              .size
                              .height * 0.05),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                                'Departure Airport : ${widget
                                    .departureAirportModel.airportName}'),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width *
                                  0.06,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width *
                                  0.06,
                            ),
                            Text(
                                'Arrival Airport : ${widget.arrivalAirportModel
                                    .airportName}'),
                          ],
                        ),
                      ),
                      SizedBox(
                          height:
                          MediaQuery
                              .of(context)
                              .size
                              .height * 0.05),
                      Text(
                          'Departure Time : ${widget.flightsModel.departureTime
                              .substring(0, 2)}:${widget.flightsModel
                              .departureTime.substring(2)}'),
                      Text(
                          'Arrival Time : ${widget.flightsModel.arrivalTime
                              .substring(0, 2)}:${widget.flightsModel
                              .arrivalTime.substring(2)}'),
                      SizedBox(
                          height:
                          MediaQuery
                              .of(context)
                              .size
                              .height * 0.05),
                      Text(
                          'Airplane ID : ${widget.flightsModel.airplaneId}'),
                      SizedBox(
                          height:
                          MediaQuery
                              .of(context)
                              .size
                              .height * 0.05),
                      const Text('Seat Status'),
                      Text(
                          'Seats : /${state.airplanesList
                              .firstWhere((e) =>
                          e.airplaneId == widget.flightsModel.airplaneId)
                              .firstClassSeat + state.airplanesList
                              .firstWhere((e) =>
                          e.airplaneId == widget.flightsModel.airplaneId)
                              .businessClassSeat + state.airplanesList
                              .firstWhere((e) =>
                          e.airplaneId == widget.flightsModel.airplaneId)
                              .economyClassSeat}'),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                                'First class : ${state.firstClass.length}/${state.airplanesList
                                    .firstWhere((e) =>
                                e.airplaneId == widget.flightsModel.airplaneId)
                                    .firstClassSeat}'),
                            SizedBox(
                              width:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.1,
                            ),
                            Text(
                                'Business class : ${state.businessClass.length}/${state.airplanesList
                                    .firstWhere((e) =>
                                e.airplaneId == widget.flightsModel.airplaneId)
                                    .businessClassSeat}'),
                            SizedBox(
                              width:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.1,
                            ),
                            Text(
                                'Economy class : ${state.economyClass.length}/${state.airplanesList
                                    .firstWhere((e) =>
                                e.airplaneId == widget.flightsModel.airplaneId)
                                    .economyClassSeat}')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
