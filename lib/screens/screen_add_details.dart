import 'package:flutter/material.dart';
import 'package:jim_ghana/screens/screen_home.dart';


class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(70),
            child: Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Icon(Icons.qr_code)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text('Add QR & Photo')),
                  ),
                ],
              ),
            ),
          ),
          const TextField(decoration: InputDecoration(labelText: '                                      Customer ID')),
          const TextField(decoration: InputDecoration(labelText: '                                    Vehicle Number')),
          Row(
            children: [
              const SizedBox(width: 100),
              const SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text('BACK', style: TextStyle(color: Colors.black),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white54),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text('Are you sure you want to close without saving?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Screen2(),
                                  )
                              );
                            },
                            child: Text('OK'),
                          ),

                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ADD VEHICLE',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white54),
                ),
              ),


            ],
          ),
        ],
      ),
    );
  }
}
