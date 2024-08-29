import 'package:flutter/material.dart';
import 'package:house/constant/app_colors.dart';
import 'package:house/model/house_model.dart';
import 'package:house/screens/book_appartment/book_appartment.dart';

class HouseRentDetailsScreen extends StatefulWidget {
  final HouseModel houseModel;
  const HouseRentDetailsScreen({super.key, required this.houseModel});

  @override
  State<HouseRentDetailsScreen> createState() => _HouseRentDetailsScreenState();
}

class _HouseRentDetailsScreenState extends State<HouseRentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroudColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    widget.houseModel.image,
                    fit: BoxFit.cover,
                    height: size.height * 0.43,
                    width: size.width,
                  ),
                ),
                Positioned(
                    top: 40,
                    right: 20,
                    left: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(15)),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(15)),
                          child: InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                    bottom: -30,
                    left: 20,
                    child: Container(
                      height: 60,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          '\$ ${widget.houseModel.price}.00/M',
                          style: const TextStyle(
                              color: kBlueTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                    )),
                Positioned(
                    bottom: -120,
                    right: 50,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.8),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ]),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.bookmark,
                          size: 30,
                        ),
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      widget.houseModel.name,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          height: 1.2),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.houseModel.place,
                    style: TextStyle(
                        height: 1.2,
                        color: kFontColor.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Room Facilties",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700, height: 2),
                    ),
                    Text(
                      "To much work. Let's burn it say we dumped it in the sewer. oh, I don't have time for this.I have to go",
                      style: TextStyle(
                        fontSize: 15,
                        color: kFontColor.withOpacity(0.7),
                      ),
                    ),
                    const Text(
                      "Read More",
                      style: TextStyle(
                          height: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: kBlueTextColor,
                          decoration: TextDecoration.underline,
                          decorationColor: kBlueTextColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _rootWidget(context, 'assets/icon1.png',
                            widget.houseModel.height),
                        _rootWidget(context, 'assets/icon2.png',
                            widget.houseModel.width),
                        _rootWidget(context, 'assets/icon3.png',
                            "${widget.houseModel.bath} Baths"),
                        _rootWidget(context, 'assets/icon4.png',
                            widget.houseModel.type),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BookAppartmentScreen(),
                            ));
                      },
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            color: const Color(0xff002140),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(22),
                            child: Text(
                              "Book The Appartment",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _rootWidget(BuildContext context, image, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 100,
          width: 80,
          decoration: BoxDecoration(
              color: kBackgroudColor, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 40,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(value),
            ],
          ),
        ),
      ],
    );
  }
}
