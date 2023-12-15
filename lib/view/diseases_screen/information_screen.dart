import 'package:edraak/model/diseases_model.dart';
import 'package:edraak/utils/textstyler_helper.dart';
import 'package:flutter/material.dart';

class DiseasesInformationScreen extends StatefulWidget {
  final DiseasesModel model;

  const DiseasesInformationScreen({super.key, required this.model});

  @override
  State<DiseasesInformationScreen> createState() =>
      _DiseasesInformationScreenState();
}

class _DiseasesInformationScreenState extends State<DiseasesInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edraak',
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ///DESCRIPTION
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Description:',
                style: TextStyleHelper.kPrimaryBlue24W700,
              ),
            ),
          ),
          Text(
            widget.model.description ?? "",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),

          ///SYMPTOMS
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Symptoms:',
                style: TextStyleHelper.kPrimaryBlue24W700,
              ),
            ),
          ),
          Text(
            widget.model.symptoms ?? "",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),

          ///PREVENTION
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Prevention:',
                style: TextStyleHelper.kPrimaryBlue24W700,
              ),
            ),
          ),
          Text(
            widget.model.prevention ?? "",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
