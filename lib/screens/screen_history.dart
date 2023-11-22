import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jim_ghana/repository/provider/exit_api_provider.dart';
import 'package:jim_ghana/screens/screen_home.dart';

import '../model_class/get_exit_vehicle.dart';

class VehicleOut extends StatefulWidget {
  const VehicleOut({super.key});

  _VehicleOutState createState() => _VehicleOutState();
}

class _VehicleOutState extends State<VehicleOut> {
  List<ExitVehicleList> exitList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getExitDetails();
  }

  getExitDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await JavaService2().getExitDetails();

      if (response != null) {
        exitList = response.exitList!;
        print(exitList.length);
        for (int i = 0; i < exitList.length; i++) {
          print(exitList[i].vehicleNumber);
        }
      }
    } catch (error) {
      print('Error: $error');
      // Handle the error if needed
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Loading...',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                const SizedBox(height: 50),
                Row(
                  children: [
                    const SizedBox(width: 35),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenHome(),
                          ),
                        );
                      }, // Handle button click logic here
                      child: const Text(
                        'VEHICLE IN',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 100),
                    TextButton(
                      onPressed: () {}, // Handle button click logic here
                      child: const Text(
                        'VEHICLE OUT',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                vehicleOutWidget(context),
              ],
            ),
    );
  }
}

Widget vehicleOutWidget(BuildContext context) {
  var time = DateTime.now();
  return Column(
    children: [
      const SizedBox(height: 50),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(color: Colors.black12),
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              labelText: 'Search vehicle number',
            ),
          ),
        ),
      ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: exitList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(exitList[index].vehicleNumber.toString()),
                        Text('Image')
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(vehicleList[index].inTime.toString()),
                        Text('Driver')
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('yyyy-MM-ddTHH:mm:ss').format(time)),
                        Text('Driver')
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      // Add more list items as needed
    ],
  );
}
