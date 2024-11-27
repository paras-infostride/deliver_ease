import 'package:deliver_ease/core/utils/app_colors.dart';
import 'package:flutter/material.dart';


Future<void> selectDateRangePicker(
    {required BuildContext context,
    required DateTimeRange? selectedDate,
    required Function(DateTimeRange) onDateSelect,
    bool isLastDateIsCurrentDay = true}) async {
  DateTime currentSelectedState = DateTime.now();

  DateTimeRange? picked = await showDateRangePicker(
    builder: (context, Widget? child)
      {

        return Theme(data: ThemeData.light().copyWith(
          useMaterial3: false,
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryColor, // header background color
            onPrimary: Colors.white, // header text color
            onSurface: Colors.black, // body text color
          ),
        ),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 50),
                    height: 650,
                    width: 450,
                    // padding: EdgeInsets.symmetric(horizontal: 600,vertical: 100),
                child: child!),
              ],
            ));
      },
    currentDate: DateTime.now(),
      context: context,
       initialDateRange: selectedDate,firstDate: DateTime(1900),  // or any other early date
    lastDate: DateTime(2100),);
  if (picked != null && picked.start != selectedDate) {
    // picked.start && picked.end
    onDateSelect(picked);
  }
}
