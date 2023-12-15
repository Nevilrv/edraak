import 'dart:developer';

import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:edraak/utils/common_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pref_manager/pref_manager.dart';
import '../../utils/color_picker.dart';
import '../../utils/sizebox_services.dart';
import '../../utils/textstyler_helper.dart';
import '../../view_model/predication_info_view_model.dart';

class PredicationScreen extends StatefulWidget {
  const PredicationScreen({Key? key}) : super(key: key);

  @override
  State<PredicationScreen> createState() => _PredicationScreenState();
}

class _PredicationScreenState extends State<PredicationScreen> {
  PredicationInfoViewModel predicationInfoViewModel =
      Get.put(PredicationInfoViewModel());

  int? _selectedYear;
  int? selected;
  int? monthIndex;
  var selectData;

  @override
  void initState() {
    predicationInfoViewModel.getPredicationData();
    // TODO: implement initState
    super.initState();
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Center(
                      child: Text(
                        'Disease Forecast',
                        style: TextStyleHelper.kBlue90025W500,
                      ),
                    ),
                  ),
                  SizeBoxService.sH20,
                  Text("Year Select", style: TextStyleHelper.kBlack18W600),
                  SizeBoxService.sH20,
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: DropdownDatePicker(
                        locale: "en",
                        inputDecoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none),
                        isDropdownHideUnderline: true,
                        isFormValidator: true,
                        startYear: 2018,
                        endYear: DateTime.now().year,
                        width: 10,
                        selectedYear: _selectedYear,
                        onChangedYear: (value) {
                          _selectedYear = int.parse(value!);
                          selected = null;
                          setState(() {});
                        },
                        boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: ColorPicker.kPrimaryBlue, width: 1.0),
                        ),
                        showDay: false,
                        showMonth: false,
                        hintTextStyle: TextStyle(color: ColorPicker.kGrey),
                      ),
                    ),
                  ),
                  SizeBoxService.sH50,
                  Text("Month Select", style: TextStyleHelper.kBlack18W600),
                  SizeBoxService.sH20,
                  Wrap(
                    runSpacing: 17,
                    verticalDirection: VerticalDirection.down,
                    spacing: 12,
                    children: List.generate(
                      12,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {});
                            selected = index;
                            monthIndex = index + 1;
                            if (selectData != null) {
                              selectData = null;
                            }

                            if (_selectedYear != null) {
                              for (var data in predicationInfoViewModel.dataList
                                  .where((element) =>
                                      element.date ==
                                      "1-${index + 1}-$_selectedYear")) {
                                selectData = "${data.diseaseName}";
                              }
                              log("DISESNAM========  >   ${selectData}");

                              ///

                              showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "In ${PreferenceManager.monthName.elementAt(int.parse('$monthIndex') - 1)}   :  ",
                                      style: TextStyleHelper.kBlack18W600,
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          selectData == null
                                              ? Center(
                                                  child: Text(
                                                  'No Predication Data Found',
                                                  style:
                                                      TextStyleHelper.kGreyW600,
                                                ))
                                              : Text(
                                                  "${PreferenceManager.diseaseNameList.elementAt(int.parse('$selectData') - 1)} have spread in Jeddah, Saudi Arabia",
                                                  style: TextStyleHelper
                                                      .kBlack16W400,
                                                ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close'),
                                        onPressed: () {
                                          setState(() {});
                                          selected = null;
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              CommonSnackBarWidget.commonSnackBar(
                                  'Please Select Year');
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selected == index
                                  ? ColorPicker.kPrimaryBlue
                                  : ColorPicker.kWhite,
                              border:
                                  Border.all(color: ColorPicker.kPrimaryBlue),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              child: Text(
                                "${PreferenceManager.monthName[index]}",
                                style: TextStyle(
                                  color: selected == index
                                      ? ColorPicker.kWhite
                                      : ColorPicker.kBlack,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizeBoxService.sH50,
                ],
              ),
            ),
          ),
          // const Spacer(),
          // Container(
          //   height: 180,
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          //   decoration: BoxDecoration(
          //     color: ColorPicker.kGrey200,
          //     borderRadius: const BorderRadius.vertical(
          //       top: Radius.circular(40),
          //     ),
          //   ),
          //   child: _selectedYear == null && selected == null
          //       ? const Center(child: Text(""))
          //       : _selectedYear == null
          //           ? Center(
          //               child: Text(
          //               'Please Select Year',
          //               style: TextStyleHelper.kGreyW600,
          //             ))
          //           : selected == null
          //               ? Center(
          //                   child: Text(
          //                   'Please Select Month',
          //                   style: TextStyleHelper.kGreyW600,
          //                 ))
          //               : selectData == null
          //                   ? Center(
          //                       child: Text(
          //                       'No Predication Data Found',
          //                       style: TextStyleHelper.kGreyW600,
          //                     ))
          //                   : Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: <Widget>[
          //                         Text(
          //                           "In ${PreferenceManager.monthName.elementAt(int.parse('$monthIndex') - 1)}   :  ",
          //                           style: TextStyleHelper.kBlack18W600,
          //                         ),
          //                         Text(
          //                           "${PreferenceManager.diseaseNameList.elementAt(int.parse('$selectData') - 1)} have spread in Jeddah, Saudi Arabia",
          //                           style: TextStyleHelper.kBlack16W400,
          //                         ),
          //                       ],
          //                     ),
          // ),
        ],
      ),
    );
  }
}
