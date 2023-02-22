import 'dart:convert';
import 'package:booking_app_mobile/models/incomingMatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  List<dynamic> incomingMatchList = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/sampleIncomingMatch.json');

    final data = await json.decode(response);

    setState(() {
      incomingMatchList =
          data.map((data) => IncomingMatch.fromJson(data)).toList();
    });
  }

  @override
  void initState() {
    super.initState();

    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return buildListView();
  }

  Scaffold buildListView() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.2),
              BlendMode.lighten,
            ),
          ),
        ),
        child: listViewBuilder(),
      ),
    );
  }

  ListView listViewBuilder() {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: incomingMatchList.length,
      itemBuilder: (context, index) {
        return jobComponent(incomingMatch: incomingMatchList[index]);
      },
    );
  }

  jobComponent({required IncomingMatch incomingMatch}) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 8, 10, 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(children: [
                  //SizedBox(width: 10),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text(
                                "${incomingMatch.yardName} - ${incomingMatch.subYardName} - ${incomingMatch.subYardType}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () {
                                _showDialog(incomingMatch: incomingMatch);
                              },
                              child: AnimatedContainer(
                                  padding: EdgeInsets.all(5),
                                  duration: Duration(milliseconds: 300),
                                  child: Center(
                                      child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))),
                            )
                          ]),
                          SizedBox(height: 0,),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color(int.parse("0xff0000ff"))
                                    .withAlpha(100),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Text(
                                incomingMatch.yardAddress,
                                style: TextStyle(color: Colors.grey[500]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ],
                          ),
                        ]),
                  )
                ]),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(int.parse("0xff0000ff")).withAlpha(20)),
                      child: Text(
                        incomingMatch.date,
                        style: TextStyle(color: Color(int.parse("0xff0000ff"))),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(int.parse("0xff0000ff")).withAlpha(20)),
                      child: Text(
                        "${incomingMatch.startTime} - ${incomingMatch.endTime}",
                        style: TextStyle(color: Color(int.parse("0xff0000ff"))),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //Confirm dialog
  _showDialog({required IncomingMatch incomingMatch}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bạn có muốn lưu thay đổi không?'),
          contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          actions: [
            TextButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Có'),
              onPressed: () {
                // Thực hiện hành động ở đây khi người dùng chọn "Có"
                setState(() {
                  //call api
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
