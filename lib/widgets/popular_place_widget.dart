import 'package:flutter/material.dart';
import 'package:house/constant/app_colors.dart';
import 'package:house/model/house_model.dart';

class PopularPlaceWidget extends StatelessWidget {
  final HouseModel houseModel;
  const PopularPlaceWidget({super.key, required this.houseModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                Positioned(
                    top: 12,
                    right: 0,
                    left: 0,
                    bottom: 12,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        houseModel.image,
                        fit: BoxFit.cover,
                      ),
                    )),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: houseModel.color,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: kBackgroudColor,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              houseModel.rating,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  houseModel.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  houseModel.place,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kFontColor.withOpacity(0.7),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${houseModel.width}ft | ${houseModel.height}ft',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${houseModel.price}.00',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: kBlueTextColor),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
