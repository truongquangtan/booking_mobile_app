import 'package:booking_app_mobile/common_components/star_rating_bar.dart';
import 'package:booking_app_mobile/models/yard_simple.dart';
import 'package:booking_app_mobile/widgets/pages/yard_view.dart';
import 'package:flutter/material.dart';
import 'package:booking_app_mobile/constant/values.dart';
import 'package:booking_app_mobile/widgets/yard_info.dart';

class YardCard extends StatefulWidget {
  final YardSimple yard;

  const YardCard({Key? key, required this.yard}) : super(key: key);

  @override
  _YardSimpleCardState createState() => _YardSimpleCardState();
}

class _YardSimpleCardState extends State<YardCard>
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

  void viewYard() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => YardPage(widget.yard.id),
      ),
    );
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
          onTap: viewYard,
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
              StarRatingBar(rating: widget.yard.score/20, size: 24),
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
                      '${widget.yard.openAt} - ${widget.yard.closeAt}',
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
                      widget.yard.address,
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
                  tag: widget.yard.images.first,
                  child: Image.network(
                    widget.yard.images.first,
                    fit: BoxFit.cover,
                    loadingBuilder: onImageLoading,
                  ),
                ),
              ),
              YardInfo(yard: widget.yard),
            ],
          ),
        ),
      ),
    );
  }
}
