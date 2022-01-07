import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Function newappointment;
  String name;

  Home(this.name, this.newappointment);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 0,
                    ),
                    Text(
                      ' Hi ${name} !',
                      style: TextStyle(fontSize: 27, fontWeight: FontWeight.w400),
                    ),
                    TextButton(onPressed: () => newappointment(1), child: Text('Make an Appointment'))
                    
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 7,
                    // ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     SizedBox(
                    //       width: double.infinity,
                    //       height: 0,
                    //     ),
                    //     Text('How you doin', style: TextStyle(fontSize: 18)),
                    //     ElevatedButton(
                    //         onPressed: () => newappointment(1),
                    //         child: Text(
                    //           'Book Appointment',
                    //           style: TextStyle(fontSize: 13),
                    //         ))
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            '  Recommended',
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(4),
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[200],
                        child: Container(
                            child: Image.asset(
                                'assets/images/doctor profile pic.png',
                                color: Colors.blue))),
                    title: Text('Dr.Mohan Babu'),
                    subtitle: Text('MBBS\nApollo,Bangalore'),
                  ),
                  Text('  Comments', style: TextStyle(fontSize: 15)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey[200],
                            child: Container(
                                child: Image.asset(
                                    'assets/images/user profile pic.png',
                                    color: Colors.blue)
                                    )),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Mrs.Ramya Krishna',style: TextStyle(fontSize: 15)),
                        
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: SizedBox(
                            width: double.infinity,
                            child: Text('Dr.Mohan is a great doctor! He’s very understanding and listens to your concerns. He takes time with the patient to help them with their health issues! I highly recommend him to anyone looking for a specialist.'),
                          ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(4),
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[200],
                        child: Container(
                            child: Image.asset(
                                'assets/images/doctor profile pic.png',
                                color: Colors.blue))),
                    title: Text('Dr.Vasu dev'),
                    subtitle: Text('Neurologist\nKIMS,Bangalore'),
                  ),
                  Text('  Comments', style: TextStyle(fontSize: 15)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey[200],
                            child: Container(
                                child: Image.asset(
                                    'assets/images/user profile pic.png',
                                    color: Colors.blue))),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Mr.Krishna Murthy',style: TextStyle(fontSize: 15)),
                        
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                            width: double.infinity,
                            child: Text('Great medical office, wonderful and warm experience from start to finish. Appreciate Dr.Vasu Dev taking time to go over the diagnosis clearly and treatment options. Was referred over by my general doctor and can see why. Highly recommended.')
                                                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
