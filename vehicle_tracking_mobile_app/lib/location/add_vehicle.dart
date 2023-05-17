import 'package:flutter/material.dart';
import 'package:vehicle_tracking_mobile_app/pages/home-page.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  _AddVehicleState createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  bool showDropdownMenu = false;
  String dropdownBrandValue = 'Toyota';
  String dropdownModelValue = 'Camry';
  String dropdownColorValue = 'Red';

  List<String> brands = ['Toyota', 'Mercedes', 'Honda', 'Suzuki'];
  List<String> models = ['Camry', 'Corolla', 'Accord', 'Swift'];
  List<String> colors = ['Red', 'Blue', 'Green', 'Black'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 125,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 115,
                ),
                child: const Text(
                  "Add Vehicle",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 5),
            child: const Text(
              "Vehicle Brand",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                readOnly: true,
                onTap: () {
                  setState(() {
                    showDropdownMenu = !showDropdownMenu;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(237, 236, 236, 1),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromRGBO(237, 236, 236, 1),
                    ),
                  ),
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ),
          ),
          if (showDropdownMenu)
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: DropdownButton<String>(
                  value: dropdownBrandValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownBrandValue = newValue!;
                    });
                  },
                  items: brands.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 5),
            child: const Text(
              "Vehicle Model",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            child: Container(
              width: 390,
              height: 60,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(237, 236, 236, 1),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: DropdownButton<String>(
                  value: dropdownModelValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownModelValue = newValue!;
                    });
                  },
                  items: models.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 5),
            child: const Text(
              "Vehicle Color",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            child: Container(
              width: 390,
              height: 60,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(237, 236, 236, 1),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: DropdownButton<String>(
                  value: dropdownColorValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownColorValue = newValue!;
                    });
                  },
                  items: colors.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 5),
            child: const Text(
              "Tracking Device ID",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(237, 236, 236, 1),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Color.fromRGBO(237, 236, 236, 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 5),
            child: const Text(
              "Upload Vehicle Image",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            height: 120,
            margin: const EdgeInsets.all(10),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromRGBO(237, 236, 236, 1),
            ),
            child: Center(
              child: IconButton(
                color: const Color.fromRGBO(175, 172, 172, 1),
                onPressed: () {},
                icon: const Icon(
                  Icons.file_upload_outlined,
                  size: 60,
                ),
              ),
            ),
          ),
          Container(
            width: 392,
            height: 60,
            margin: const EdgeInsets.only(left: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 27, 187, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Add Vehicle",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 50.0,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    children: [
                      const Icon(
                        Icons.verified,
                        color: Color.fromARGB(255, 27, 187, 1),
                        size: 110.0,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 130.0,
                            child: const Text(
                              "Successful",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const Text(
                            "Your vehicle has been added",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 60,
                        margin: const EdgeInsets.only(
                          left: 22.5,
                          right: 22.5,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 27, 187, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Back to Home",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
//  Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 130.0,
//                             child: const Text(
//                               "Successful",
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                           ),
//                           const Text(
//                             "Your vehicle has been added",
//                             style: TextStyle(
//                               color: Colors.black87,
//                               fontSize: 17,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Container(
//                         height: 60,
//                         margin: const EdgeInsets.only(
//                           left: 22.5,
//                           right: 22.5,
//                         ),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 const Color.fromARGB(255, 27, 187, 1),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const HomePage(),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             "Back to Home",
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),