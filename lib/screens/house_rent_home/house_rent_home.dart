// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:house/constant/app_colors.dart';
import 'package:house/model/house_model.dart';
import 'package:house/screens/house_rent_details/house_rent_details.dart';
import 'package:house/screens/sign_up/sign_up.dart';
import 'package:house/screens/view_all/view_all.dart';
import 'package:house/widgets/horizontal_data_widget.dart';
import 'package:house/widgets/popular_place_widget.dart';

class HouseRentHomeScreen extends StatefulWidget {
  const HouseRentHomeScreen({super.key});

  @override
  State<HouseRentHomeScreen> createState() => _HouseRentHomeScreenState();
}

class _HouseRentHomeScreenState extends State<HouseRentHomeScreen> {
  String? dropdownBeds = '2-4 Beds';
  String? drowpdownFilter = 'Short by: Price';
  User? user;
  String location = "Locating...";
  List<HouseModel> filteredHouseList = [];

  @override
  void initState() {
    super.initState();
    getUserData();
    _determinePosition();
    filteredHouseList = List.from(houseList);
  }

  void getUserData() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {}
    setState(() {});
  }

  void filterHouses() {
    List<HouseModel> tempList = List.from(houseList);

    switch (drowpdownFilter) {
      case 'Short by: Price':
        tempList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Short by: Name':
        tempList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Short by: type':
        tempList.sort((a, b) => a.type.compareTo(b.type));
        break;
    }

    setState(() {
      filteredHouseList = tempList;
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        location = "Location services are disabled.";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          location = "Location permissions are denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        location = "Location permissions are permanently denied.";
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];
      setState(() {
        location = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        location = "Unable to get place information.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroudColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _topBarItems(context),
          ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 370,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredHouseList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HouseRentDetailsScreen(
                                houseModel: filteredHouseList[index],
                              ),
                            ));
                      },
                      child: DisplayItemsHorizontal(
                        houseModel: filteredHouseList[index],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              _popularPlaceWidget(context),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                reverse: true,
                physics: const ScrollPhysics(),
                itemCount: filteredHouseList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HouseRentDetailsScreen(
                                houseModel: filteredHouseList[index],
                              ),
                            ));
                      },
                      child: PopularPlaceWidget(
                          houseModel: filteredHouseList[index]));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBarItems(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            location,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: kFontColor),
          ),
          subtitle: Row(
            children: [ 
              Text(
                user?.email != null
                    ? user!.email!.split('@')[0].toUpperCase()
                    : "User",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: kFontColor,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: kBackgroudColor,
                  title: const Text(
                    "Are You Sure to Logout?",
                    style: TextStyle(color: kBlueTextColor),
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ));
                        } catch (e) {
                          print("Error signing out: $e");
                        }
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              size: 30,
            ),
            color: kBlueTextColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 25,
                  ),
                  underline: Container(),
                  value: drowpdownFilter,
                  items: [
                    'Short by: Price',
                    'Short by: Name',
                  ]
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )))
                      .toList(),
                  onChanged: (String? beds) {
                    setState(() {
                      drowpdownFilter = beds;
                      filterHouses();
                    });
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _popularPlaceWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white70, borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: const Text(
            "Popular Place",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          trailing: InkWell(
            onTap: () {
              List<HouseModel> topRatedHouses =
                  filteredHouseList.where((house) {
                double ratingValue = double.tryParse(house.rating) ?? 0.0;
                return ratingValue >= 4.9;
              }).toList();

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewAllScreen(
                      topRatedHouses: topRatedHouses,
                    ),
                  ));
            },
            child: Text(
              "View All",
              style: TextStyle(
                fontSize: 15,
                decoration: TextDecoration.underline,
                decorationColor: kFontColor.withOpacity(0.7),
                color: kFontColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
