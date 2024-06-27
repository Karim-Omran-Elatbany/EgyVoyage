import 'dart:io';


import 'package:egyvoyage/Booking/Constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class ResultPage extends StatefulWidget {
  final List<Map<String, String>> labelsInfo;
  final File? imageFile;

  const ResultPage({Key? key, required this.labelsInfo, this.imageFile}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final String appBarTitle = widget.labelsInfo.isNotEmpty ? widget.labelsInfo[0]['text'] ?? 'Unknown' : 'Unknown';

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration:const  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/photo/model/backGround-model.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        return Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close, size: 24),
                    ),
                    Text(
                      appBarTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const  SizedBox(width: 24), // Adjust as needed for spacing
                  ],
                ),
                const  SizedBox(height: 13),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                      itemCount: widget.labelsInfo.length,
                      itemBuilder: (context, index) {
                        final labelInfo = widget.labelsInfo[index];
                        return ListTile(
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 300,
                                width: MediaQuery.of(context).size.height * .3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color:const Color(0xffFBE2AE).withOpacity(.5),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: AspectRatio(
                                    aspectRatio: 2.8 / 4,
                                    child: widget.imageFile != null ? Image.file(widget.imageFile!) : Container(),
                                  ),
                                ),
                              ),
                              const  SizedBox(height: 16),
                              Container(
                                height: 400,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Color(0xffFBE2AE).withOpacity(.5),
                                ),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SelectableText(
                                            labelInfo['description'] ?? 'No description available',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Color(0xff303030),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                height: 70,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: const Color(0xffFBE2AE).withOpacity(.6),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 24,
                                          color: kPrimaryColor,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              launchURL(labelInfo['location']!);
                                            },
                                            child: Text(
                                              labelInfo['location'] ?? 'No location available',
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: const TextStyle(
                                                color: Color(0xff32495E),
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


