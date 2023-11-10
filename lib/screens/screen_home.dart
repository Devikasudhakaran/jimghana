import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jim_ghana/screens/screen_add_details.dart';



 void main()  {
   runApp(const MaterialApp(
    home: Screen2(),
  ));
}

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
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
                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VehicleOut(),
                    ));}, // Handle button click logic here
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
              builder: (context) => Screen3(),
            ),
          );
        },
        child: Text('Add'),
        backgroundColor: Colors.black12,
        foregroundColor: Colors.black,
        shape: BeveledRectangleBorder(),
      ),
    );
  }
}


Widget vehicleInWidget(BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 50),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: const BoxDecoration(color: Colors.black12),
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
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
                endActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.grey.shade400,
                      foregroundColor: Colors.black,
                      label: 'Exit',
                      onPressed: (context) {
                        // Use Navigator to navigate to the VehicleOut page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VehicleOut()),
                        );
                      },
                    ),
                  ],
                ),

            child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,

                ),
                child: const Column(
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('KL03 507'), Text('Image')],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('2023-10-30 07:15:00 '), Text('Driver')],
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

class VehicleOut extends StatelessWidget {
  const VehicleOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                      builder: (context) => const Screen2(),
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
  return Column(
    children: [
      const SizedBox(height: 50),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: const BoxDecoration(color: Colors.black12),
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
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return  Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Column(
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Vehicle number'), Text('Image')],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('In Time'), Text('Driver')],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Out Time'), Text('Driver')],
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



