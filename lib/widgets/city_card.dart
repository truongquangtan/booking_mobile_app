import 'package:flutter/material.dart';
import 'package:booking_app_mobile/constant/values.dart';
import 'package:booking_app_mobile/models/city_model.dart';
import 'package:booking_app_mobile/widgets/city_info.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CityCard extends StatefulWidget {
  final CityModel city;

  const CityCard({Key? key, required this.city}) : super(key: key);

  @override
  _CityCardState createState() => _CityCardState();
}

class _CityCardState extends State<CityCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void viewCity() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => DetailPage(city: widget.city),
    //   ),
    // );
  }

  Widget onImageLoading(context, Widget child, ImageChunkEvent? progress) {
    if (progress == null) return child;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: CircularProgressIndicator(
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                : null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.6;
    return ScaleTransition(
      scale: CurvedAnimation(
          parent: animationController, curve: Curves.easeInToLinear),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: cardWidth,
        child: InkWell(
          onTap: viewCity,
          customBorder: roundedRect16,
          child: Stack(
            children: <Widget>[
              buildInfoCard(context, cardWidth),
              //buildImageCard(cardWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(context, cardWidth) {
    return SizedBox(
      width: cardWidth,
      child: Card(
        elevation: 3,
        shape: roundedRect12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              buildImageCard(cardWidth),
              SizedBox(height: 16,),
              buildRating(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_alarm,
                      color: Color.fromARGB(255, 128, 125, 125)),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      '${widget.city.startTime} - ${widget.city.endTime}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      color: Color.fromARGB(255, 128, 125, 125)),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      widget.city.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageCard(cardWidth) {
    return Container(
      width: cardWidth,
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Card(
        shape: roundedRect16,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Hero(
                  tag: widget.city.image,
                  child: Image.network(
                    widget.city.image,
                    fit: BoxFit.cover,
                    loadingBuilder: onImageLoading,
                  ),
                ),
              ),
              CityInfo(city: widget.city),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRating() {
    return RatingBar(
      initialRating: widget.city.rating,
      allowHalfRating: true,
      direction: Axis.horizontal,
      itemCount: 5,
      itemSize: 25,
      unratedColor: Colors.black,
      itemPadding: const EdgeInsets.only(right: 4.0),
      ignoreGestures: true,
      onRatingUpdate: (rating) {},
      ratingWidget: RatingWidget(
        full: const Icon(Icons.star, color: Colors.orangeAccent),
        half: const Icon(Icons.star, color: Colors.orangeAccent),
        empty: const Icon(Icons.star_border, color: Colors.orangeAccent),
      ),
    );
  }
}
