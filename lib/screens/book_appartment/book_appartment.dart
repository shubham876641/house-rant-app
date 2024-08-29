// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house/constant/app_colors.dart';
import 'package:house/screens/thank_you/thank_you.dart';

class BookAppartmentScreen extends StatefulWidget {
  const BookAppartmentScreen({super.key});

  @override
  State<BookAppartmentScreen> createState() => _BookAppartmentScreenState();
}

class _BookAppartmentScreenState extends State<BookAppartmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  @override
  void dispose() {
    _aadhaarController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroudColor,
        title: const Text(
          "Registration",
          style: TextStyle(
              color: kBlueTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 4),
        ),
      ),
      backgroundColor: kBackgroudColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_formWidget(context), _buttonWidget(context)],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _formWidget(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(12)
            ],
            controller: _aadhaarController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Aadhaar No';
              } else if (value.length != 12) {
                return 'Aadhaar No should be 12 digits long';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: 'Addhar No',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Phone Number';
              } else if (value.length != 10) {
                return 'Phone Number should be 10 digits long';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: 'Phone Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          TextFormField(
            controller: _addressController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Vilage Name';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: 'Vilage Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          TextFormField(
            controller: _cityController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter City Name';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: 'City Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          TextFormField(
            controller: _pincodeController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6)
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter PinCode ';
              } else if (value.length < 6) {
                return 'Phone Number should be 6 digits long';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: 'PinCode',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),
    );
  }

  Widget _buttonWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: InkWell(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            String aadhaarNo = _aadhaarController.text;
            String phoneNumber = _phoneController.text;
            String villageName = _addressController.text;
            String cityName = _cityController.text;
            String pinCode = _pincodeController.text;

            Map<String, dynamic> data = {
              'aadhaarNo': aadhaarNo,
              'phoneNumber': phoneNumber,
              'villageName': villageName,
              'cityName': cityName,
              'pinCode': pinCode,
              'createdAt': FieldValue.serverTimestamp()
            };
            try {
              await FirebaseFirestore.instance.collection('123456').add(data);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking saved successfully!')),
              );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThankYouScreen(),
                  ));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: $e')),
              );
            }
          }
        },
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
              color: const Color(0xff002140),
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Submit Document",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
