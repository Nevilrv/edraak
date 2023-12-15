import 'package:edraak/utils/color_picker.dart';
import 'package:edraak/utils/common_button_widget.dart';
import 'package:edraak/utils/sizebox_services.dart';
import 'package:edraak/utils/textstyler_helper.dart';
import 'package:edraak/view/diseases_screen/information_screen.dart';
import 'package:edraak/view_model/diseases_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListOfDiseasesScreen extends StatefulWidget {
  const ListOfDiseasesScreen({super.key});

  @override
  State<ListOfDiseasesScreen> createState() => _ListOfDiseasesScreenState();
}

class _ListOfDiseasesScreenState extends State<ListOfDiseasesScreen> {
  DiseasesViewModel diseasesViewModel = Get.put(DiseasesViewModel());

  @override
  void initState() {
    super.initState();
    diseasesViewModel.getDiseasesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edraak',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Text(
              'List of Diseases',
              style: TextStyleHelper.kBlue90025W500,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ColorPicker.kGrey200,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
                child: GetBuilder<DiseasesViewModel>(
                  builder: (controller) {
                    if (controller.isLoader) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.separated(
                      itemCount: controller.diseasesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: index == 0 ? 100 : 0),
                          child: CommonButton()
                              .bSquareRoundBorderPrimaryBlueButton(
                            height: 70,
                            context,
                            title: controller.diseasesList[index].name ?? "",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DiseasesInformationScreen(
                                    model: controller.diseasesList[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizeBoxService.sH30,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
