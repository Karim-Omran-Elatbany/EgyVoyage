import 'package:egyvoyage/Home_view/widgets/maps.dart';
import 'package:flutter/material.dart';
import '../../Services/models/placesmodel.dart';

class PostBottomBar extends StatefulWidget {
  PostBottomBar(this.placeseModel);

  final PlaceseModel placeseModel;

  @override
  State<PostBottomBar> createState() => _PostBottomBarState();
}

class _PostBottomBarState extends State<PostBottomBar> {
  Future<List<double>> getCoordinates() async {
    List<String> parts = widget.placeseModel.cordinate!.split(",");
    double latitude = double.parse(parts[0]);
    double longitude = double.parse(parts[1]);
    return [latitude, longitude];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height / 3) * 2,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.placeseModel.name ?? '',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 25,
                        ),
                        Text(
                          "${widget.placeseModel.rating ?? 0}",
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "Description:",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.placeseModel.description ?? "",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 15),
                Text(
                  'Location:',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.placeseModel.url_location ?? '',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<double>>(
                  future: getCoordinates(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.length != 2) {
                      return Center(child: Text('Invalid data'));
                    }

                    double latitude = snapshot.data![0];
                    double longitude = snapshot.data![1];

                    return PlacesMaps(latitude, longitude);
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  'Opening Hours',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "( ${widget.placeseModel.start ?? ''} am - ${widget.placeseModel.end ?? ''} pm ) every day",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Ticket prices:',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      ' - Adult: ',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      //'${widget.placeseModel.adultprice ?? "0"} '
                      'EGP',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      '/ticket',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      ' - Children: ',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      //'${widget.placeseModel.childprice}'
                      'EGP',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      '/ticket',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      ' - Tourists: ',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      //'${widget.placeseModel.tourist} '
                      'EGP',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      '/ticket',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
