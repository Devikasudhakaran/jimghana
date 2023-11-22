import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jim_ghana/repository/provider/exit_api_provider.dart';
import 'package:jim_ghana/screens/screen_add_details.dart';
import 'package:jim_ghana/screens/screen_history.dart';

import '../model_class/get_vehicle_response.dart';
import '../repository/provider/add_api_provider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<GetVehicleList> vehicleList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // print('service3');
    getDetails();
  }

  getDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await JavaService().getDetails();

      if (response != null) {
        vehicleList = response.vehicleList!;
        print(vehicleList.length);
        for (int i = 0; i < vehicleList.length; i++) {
          print(vehicleList[i].vehicleNumber);
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

  getExitDetails(int index) async {
    // setState(() {
    //   isLoading = true;
    // });

    try {
      var response =
          await JavaService2().exitDetails(vehicleList[index].id.toString());

      if (response != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VehicleOut(),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      // Handle the error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: const Row(
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
                    const TextButton(
                      onPressed: null, // Handle button click logic here
                      child: Text(
                        'VEHICLE IN',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 100),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VehicleOut(),
                            ));
                      }, // Handle button click logic here
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
                vehicleInWidget(context),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Screen3(),
            ),
          );
        },
        child: Text('Add'),
        backgroundColor: Colors.black12,
        foregroundColor: Colors.black,
        shape: const BeveledRectangleBorder(),
      ),
    );
  }

  Widget vehicleInWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: const BoxDecoration(color: Colors.black12),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
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
            itemCount: vehicleList.length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.grey.shade400,
                      foregroundColor: Colors.black,
                      label: 'Exit',
                      onPressed: (context) async {
                        // await JavaService2().exitDetails(
                        //     vehicleList[index].id.toString());
                        getExitDetails(index);

                        // print('hello');
                      },
                    ),
                  ],
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(vehicleList[index].vehicleNumber.toString()),
                            const Text('Image')
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(vehicleList[index].inTime.toString()),
                            const Text('Driver')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
