import 'package:admin_web_app/data/model/flights/flights_model.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Container(color: const Color(0xFFfbf2ff),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Flight ID : ${widget.flightsModel.flightId}'),
              Text('Flight Date : ${widget.flightsModel.flightDate}'),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              Row(
                children: [
                  Text('Departure Airport : ${widget.flightsModel.departureLoc}'),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Text('Arrival Airport : ${widget.flightsModel.arrivalLoc}'),
                ],
              ),
              Row(
                children: [
                  Text('Departure Time : ${widget.flightsModel.departureTime}'),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Text('Arrival Time : ${widget.flightsModel.arrivalTime}'),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              Text('Airplane ID : ${widget.flightsModel.airplaneId}'),
              const Text('Seat Status'),
            ],
          ),
        ),
      ),
    );
  }
}
