import 'package:flutter/material.dart';


class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              const SizedBox(width: 35),
              const TextButton(
                onPressed: null,
                child: Text(
                  'VEHICLE IN',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              const SizedBox(width: 130),
              TextButton(
                onPressed:  null,
                child: const Text(
                  'VEHICLE OUT',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
          const VehicleIn(),
        ],
      ),
    );
  }
}




class VehicleIn extends StatelessWidget {
  const VehicleIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
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
        SizedBox(height: 20),
        // Add more list items as needed
      ],
    );
  }
}

