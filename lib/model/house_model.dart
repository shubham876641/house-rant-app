import 'package:flutter/material.dart';

class HouseModel {
  final String name;
  final String place;
  final String price;
  final String height;
  final String width;
  final String bath;
  final String type;
  final String rating;
  final String image;
  final Color color;
  HouseModel({
    required this.name,
    required this.place,
    required this.price,
    required this.height,
    required this.width,
    required this.bath,
    required this.type,
    required this.rating,
    required this.image,
    required this.color,
  });
}

List<HouseModel> houseList = [
  HouseModel(
      name: 'Rose Cottage.',
      place: "Pune , Maharastra",
      price: "123456",
      height: "12.5",
      width: "18.5",
      bath: "2",
      type: "Family",
      rating: "4.5",
      image: 'assets/image1.jpg',
      color: const Color(0xff7aafff)),
  HouseModel(
      name: 'Blue Haven',
      place: "Mumbai, Maharashtra",
      price: "200000",
      height: "15.0",
      width: "20.0",
      bath: "3",
      type: "Apartment",
      rating: "4.6",
      image: 'assets/h1.png',
      color: const Color(0xff6fcf97)),
  HouseModel(
      name: 'Sunset Villa',
      place: "Goa, India",
      price: "350000",
      height: "20.0",
      width: "25.0",
      bath: "4",
      type: "Villa",
      rating: "4.7",
      image: 'assets/image2.jpg',
      color: Colors.orangeAccent),
  HouseModel(
      name: 'Maple Retreat',
      place: "Shimla, Himachal Pradesh",
      price: "180000",
      height: "12.0",
      width: "18.0",
      bath: "2",
      type: "Cottage",
      rating: "4.8",
      image: 'assets/image3.jpg',
      color: Colors.brown),
  HouseModel(
      name: 'Emerald Apartments',
      place: "Bangalore, Karnataka",
      price: "220000",
      height: "16.0",
      width: "22.0",
      bath: "3",
      type: "Apartment",
      rating: "4.9",
      image: 'assets/image4.jpg',
      color: Colors.teal),
  HouseModel(
      name: 'Oceanview Mansion',
      place: "Chennai, Tamil Nadu",
      price: "500000",
      height: "25.0",
      width: "30.0",
      bath: "5",
      type: "Mansion",
      rating: "4.9",
      image: 'assets/image5.jpg',
      color: Colors.blueAccent),
  HouseModel(
      name: 'Hilltop Cabin',
      place: "Manali, Himachal Pradesh",
      price: "150000",
      height: "10.5",
      width: "14.5",
      bath: "2",
      type: "Cabin",
      rating: "4.9",
      image: 'assets/image6.jpg',
      color: Colors.greenAccent),
];
