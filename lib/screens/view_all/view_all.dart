import 'package:flutter/material.dart';
import 'package:house/constant/app_colors.dart';
import 'package:house/model/house_model.dart';
import 'package:house/screens/house_rent_details/house_rent_details.dart';
import 'package:house/widgets/popular_place_widget.dart';

class ViewAllScreen extends StatefulWidget {
  final List<HouseModel> topRatedHouses;

  const ViewAllScreen({super.key, required this.topRatedHouses});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Popular Place",
          style: TextStyle(
            color: kFontColor,
          ),
        ),
      ),
      backgroundColor: kBackgroudColor,
      body: ListView.builder(
        itemCount: widget.topRatedHouses.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HouseRentDetailsScreen(
                      houseModel: widget.topRatedHouses[index],
                    ),
                  ));
            },
            child: PopularPlaceWidget(
              houseModel: widget.topRatedHouses[index],
            ),
          );
        },
      ),
    );
  }
}
