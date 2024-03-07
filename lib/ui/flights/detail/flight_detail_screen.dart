import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:flutter/material.dart';

class FlightDetailScreen extends StatefulWidget {
  const FlightDetailScreen({
    super.key,
    required this.flightsModel,
  });

  final FlightsModel flightsModel;

  @override
  State<FlightDetailScreen> createState() => _FlightDetailScreenState();
}

class _FlightDetailScreenState extends State<FlightDetailScreen> {
  @override
  Widget build(BuildContext context) {
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
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFfbf2ff)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Flight ID : ${widget.flightsModel.flightId}'),
                      Text('Flight Date : ${widget.flightsModel.flightDate}'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                                'Departure Airport : ${widget.flightsModel.departureLoc}'),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            Text(
                                'Arrival Airport : ${widget.flightsModel.arrivalLoc}'),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                                'Departure Time : ${widget.flightsModel.departureTime}'),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.111,
                            ),
                            Text(
                                'Arrival Time : ${widget.flightsModel.arrivalTime}'),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text('Airplane ID : ${widget.flightsModel.airplaneId}'),
                      const Text('Seat Status'),
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
