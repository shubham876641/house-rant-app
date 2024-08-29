import 'package:flutter/material.dart';
import 'package:house/constant/app_colors.dart';
import 'package:house/model/house_model.dart';

class DisplayItemsHorizontal extends StatelessWidget {
  final HouseModel houseModel;
  const DisplayItemsHorizontal({super.key, required this.houseModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 8,
        left: 18,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Hero(
              tag: houseModel.image,
              child: Image.asset(
                houseModel.image,
                fit: BoxFit.cover,
                height: 220,
                width: 250,
              ),
            ),
          ),
          Container(
            height: 140,
            width: 250,
            padding: const EdgeInsets.only(top: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  houseModel.name,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 20, height: 1.2),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  houseModel.place,
                  maxLines: 2,
                  style: const TextStyle(color: kFontColor),
                ),
                Row(
                  children: [
                    Text(
                      '\$ ${houseModel.price}.00',
                      style: const TextStyle(
                          fontSize: 22,
                          color: kBlueTextColor,
                          fontWeight: FontWeight.w800),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 41,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              )
                            ]),
                        child: Icon(
                          Icons.bookmark,
                          color: kBackgroudColor,
                          size: 24,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            width: 40,
          )
        ],
      ),
    );
  }
}
