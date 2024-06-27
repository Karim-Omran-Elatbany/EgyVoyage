import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../CustomsWidget/custom_button.dart';
import '../Constant/constant.dart';
import '../widgets/app_bar_container.dart';
class SelectDateScreen extends StatelessWidget {
  SelectDateScreen({super.key});
  static const String id='selectDateScreen';
  DateTime? rangeStartDate = DateTime.now();
  DateTime? rangeEndDate = DateTime.now().add(const Duration(days: 1));
  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        titleString: 'Select Date',
        child: Column(
          children: [
            const SizedBox(height: 80,),
            SfDateRangePicker(
              view: DateRangePickerView.month,
              minDate: rangeStartDate,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(rangeStartDate,rangeEndDate),
              monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              selectionColor: Colors.yellow,
              startRangeSelectionColor: Colors.yellow,
              endRangeSelectionColor: Colors.yellow,
              rangeSelectionColor: Colors.yellow.withOpacity(0.25),
              todayHighlightColor: Colors.yellow,
              toggleDaySelection: true,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args){
                if(args.value is PickerDateRange){
                  rangeStartDate=args.value.startDate;
                  rangeEndDate=args.value.endDate;
                  print('startdate: $rangeStartDate');
                  print('enddate:$rangeEndDate');
                }
                else{
                  rangeStartDate=null;
                  rangeEndDate=null;
                }
              },


            ),
            CustomButton(
              text: 'Select',
              onPressed: (){
                if(rangeEndDate!=null){
                Navigator.of(context).pop([rangeStartDate,rangeEndDate]);}
                else{
                  AnimatedSnackBar.rectangle(
                    'Warning',
                    'Please Select a Checkout Date',
                    type: AnimatedSnackBarType.warning,
                    brightness: Brightness.dark,
                    duration: const Duration(seconds: 2)
                  ).show(
                    context,
                  );
                }
              },
            ),
            const SizedBox(height: kMediumPadding,),
            CustomButton(
              text: 'Cancel',
              onPressed: (){
                Navigator.of(context).pop([rangeStartDate,rangeEndDate]);
              },
            ),

          ],

        )
    );
  }
}
