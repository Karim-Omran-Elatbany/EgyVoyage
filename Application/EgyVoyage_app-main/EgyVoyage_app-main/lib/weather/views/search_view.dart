// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:egyvoyage/weather/constants/assets.dart';
import 'package:egyvoyage/weather/constants/colors.dart';
import 'package:egyvoyage/weather/cubits/get_wether_cubit.dart';
import 'package:egyvoyage/weather/widgets/custom_text.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.mainColor,
        foregroundColor: Colors.white,
        title: const CustomText('search a City !', color: Colors.white),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                colors: [
              MyColors.mainColor.withOpacity(.9),
              MyColors.mainColor.withOpacity(.3)
            ])),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.assetsImagesAnimationLnqy7mvh),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: TextField(
                      onSubmitted: (cityName) async {
                        var fun = BlocProvider.of<GetWeatherCubit>(context);
                        fun.getWeather(cityName: cityName);
                        controller.clear();
                        Navigator.of(context).pop();
                        print(BlocProvider.of<GetWeatherCubit>(context)
                            .weatherModel!
                            .cityName);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                      ],
                      style: const TextStyle(color: Colors.white),
                      cursorColor: MyColors.mainColor,
                      keyboardType: TextInputType.name, //phone Yes -- pc NO
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: 'search',
                        hintText: 'Enter city name',
                        hintStyle: GoogleFonts.montserrat(color: Colors.white),
                        labelStyle: GoogleFonts.montserrat(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.mainColor.withOpacity(0.6),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
