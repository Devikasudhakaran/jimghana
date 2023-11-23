import 'package:flutter/material.dart';
import 'package:jim_ghana/repository/provider/exit_api_provider.dart';

import '../model_class/get_exit_vehicle.dart';

class VehicleOut extends StatefulWidget {
  const VehicleOut({super.key});

  _VehicleOutState createState() => _VehicleOutState();
}

class _VehicleOutState extends State<VehicleOut> {
  List<ExitVehicleList> exitList = [];
  List<ExitVehicleList> filteredExitList = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();

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
        setState(() {
          exitList = response.exitList!;
          filteredExitList =
              exitList; // Initialize filtered list with all items
        });
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

  void filterList(String query) {
    setState(() {
      if (query.isEmpty) {
        // If the query is empty, show all items
        filteredExitList = exitList;
      } else {
        // Filter the list based on the search query
        filteredExitList = exitList
            .where((exit) =>
                exit.vehicleNumber!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
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
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.black12),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (query) {
                          filterList(query);
                        },
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
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: List.generate(filteredExitList.length, (index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(filteredExitList[index]
                                            .vehicleNumber
                                            .toString()),
                                        Text('Image')
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'In Time: ${filteredExitList[index].inTime.toString()}'),
                                        Text('Driver')
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'Out Time: ${filteredExitList[index].outTime.toString()}'),
                                        Text('Driver')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
