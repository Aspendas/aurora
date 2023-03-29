import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'info_organization.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with TickerProviderStateMixin {
  late var selectedCountry;
  final _organizationdata =
      FirebaseFirestore.instance.collection("organizations");
  late final AnimationController _worldController =
      AnimationController(vsync: this, duration: const Duration(seconds: 9));

  final countryList = <String>[
    'Please Select',
    'USA',
    'Turkey',
    'Spain',
    'Europe',
    'China'
  ];

  void dispose() {
    _worldController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedCountry = 'Please Select';
    // set initial value
    _worldController.forward(from: 0.4);
    _worldController.addListener(() {
      if (_worldController.isCompleted) {
        _worldController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffDAF0F0),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: Text(
                  "Select a country to find professional help",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  height: 40,
                  width: double.infinity,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        value: selectedCountry,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Robotomono",
                            fontWeight: FontWeight.w400),
                        onChanged: (String? value) {
                          setState(() {
                            selectedCountry = value;
                          });
                        },
                        items: countryList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    child: selectedCountry == 'Please Select'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'images/world.json',
                                controller: _worldController,
                                width: 600,
                                height: 600,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              FutureBuilder(
                                future: _organizationdata
                                    .doc(selectedCountry)
                                    .get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return ListView.builder(
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data['name'].length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 12.0),
                                          child: Organization(
                                            title: snapshot.data['name'][index],
                                            body: snapshot.data['body'][index],
                                            url: Uri.parse(
                                                snapshot.data['URLs'][index]),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
