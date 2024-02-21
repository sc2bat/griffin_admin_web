import 'package:admin_web_app/data/repository/airports_repository_impl.dart';
import 'package:flutter/material.dart';

import '../../data/model/airports_model.dart';

class AirportsScreen extends StatefulWidget {
  const AirportsScreen({super.key});

  @override
  State<AirportsScreen> createState() => _AirportsScreenState();
}

class _AirportsScreenState extends State<AirportsScreen> {
  final repository = AirportsRepositoryImpl();

  List<AirportsModel> airportsInfo = [];

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
      body: ListView.builder(
        itemCount: airportsInfo.length,
        itemBuilder: (context, index) {
          return Text(airportsInfo[index].airportName);
        },
      ),
    );
  }
}
