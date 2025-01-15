import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jim_ghana/screens/screen_add_details.dart';
import 'package:jim_ghana/screens/screen_history.dart';

import '../model_class/get_exit_vehicle.dart';
import '../model_class/get_vehicle_response.dart';
import '../repository/provider/add_api_provider.dart';
import '../repository/provider/exit_api_provider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome>
    with SingleTickerProviderStateMixin {
  final TextEditingController _vehicleInSearchController =
      TextEditingController();
  bool isLoading = false;
  List<GetVehicleList> vehicleList = [];
  List<GetVehicleList> filteredVehicleList = [];
  List<ExitVehicleList> exitList = [];
  List<ExitVehicleList> filteredExitList = [];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        setState(() {
          vehicleList = response.vehicleList!;
          filteredVehicleList = vehicleList;
        });
        // print(vehicleList.length);
        // for (int i = 0; i < vehicleList.length; i++) {
        //   print(vehicleList[i].vehicleNumber);
        // }
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
    try {
      var response =
          await JavaService2().exitDetails(vehicleList[index].id.toString());

      if (response != null) {
        setState(() {
          getDetails();
        });
      }
    } catch (error) {
      print('Error: $error');
      // Handle the error if needed
    }
  }

  void filterVehicleList(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredVehicleList = vehicleList;
      } else {
        filteredVehicleList = vehicleList
            .where((vehicle) => vehicle.vehicleNumber!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            : Column(
                children: [
                  const SizedBox(height: 80),
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'VEHICLE IN',
                      ),
                      Tab(
                        text: 'VEHICLE OUT',
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        vehicleInWidget(context),
                        VehicleOut(),
                      ],
                    ),
                  ),
                ],
              ),
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
              controller: _vehicleInSearchController,
              onChanged: (query) {
                filterVehicleList(query);
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
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: filteredVehicleList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Slidable(
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.grey.shade400,
                          foregroundColor: Colors.black,
                          label: 'Exit',
                          onPressed: (context) async {
                            getExitDetails(index);
                          },
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(filteredVehicleList[index]
                                    .vehicleNumber
                                    .toString()),
                                const Text('Image')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'In Time: ${filteredVehicleList[index].inTime.toString()}'),
                                const Text('Driver')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Screen3(),
                  ),
                );
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.black),
              ), // <-- Closing parenthesis was missing here
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
