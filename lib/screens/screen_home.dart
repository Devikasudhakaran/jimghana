import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jim_ghana/repository/provider/add_api_provider.dart';
import 'package:jim_ghana/screens/screen_add_details.dart';
import 'package:jim_ghana/screens/screen_history.dart';

import '../model_class/get_vehicle_response.dart';





//  void main()  {
//    runApp(MaterialApp(
//     home: Screen2(),
//   ));
// }

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<GetVehicleList> vehicleList = [];


   @override
  void initState() {
     super.initState();
     print('service3');
    getDetails();
  }

  getDetails() async {
    print('service4');
     var response = await JavaService().getDetails();
     if (response != null) {
       setState(() {
         vehicleList = response.vehicleList!;
        // print(vehicleList[3].vehicleNumber);
       });
     }

  }

   @override
  Widget build(BuildContext context) {
    // print(vehicleList[3].vehicleNumber);
    return Scaffold(
      body: ListView(
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
          Navigator.push(
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
    //print(vehicleList[3].vehicleNumber);
    return Column(
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
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
                      onPressed: (context) {
                        // Use Navigator to navigate to the VehicleOut page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const VehicleOut()),
                        );
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
                          children: [Text(vehicleList[index].vehicleNumber.toString()), const Text('Image')],
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





