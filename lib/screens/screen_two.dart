import 'package:flutter/material.dart';
import 'package:jim_ghana/screens/screen_three.dart';

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
                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const vehicleout(),
                    ));},
                child: const Text(
                  'VEHICLE OUT',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
          const vehiclein(),
        ],
      ),
    );
  }
}


class vehiclein extends StatelessWidget {
  const vehiclein({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: const BoxDecoration(color: Colors.black12),
            child: TextField(
              decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  labelText: 'Search vehicle number'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Column(
              children: [
                SizedBox(
                  height: 20,
                ),
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
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 250,
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding:  EdgeInsets.all(25),
              child: ElevatedButton(

                  child:  Text('ADD', style: TextStyle(color: Colors.black),
                  ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white54),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  Screen3(),
                    ),);
                },
              ),
            ),
        ),
      ],
    );
  }
}


class vehicleout extends StatelessWidget {
  const vehicleout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              const SizedBox(width: 35),
              TextButton(
                onPressed: () {Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const vehicleout(),
                    ));},
                child: const Text(
                  'VEHICLE IN',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              const SizedBox(width: 130),
              const TextButton(
                onPressed: null,
                child: Text(
                  'VEHICLE OUT',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: const BoxDecoration(color: Colors.black12),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelText: 'Search vehicle number'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Vehicle number'), Text('Image'),],
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
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


