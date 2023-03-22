import 'package:booking_app_mobile/common_components/loading.dart';
import 'package:booking_app_mobile/cubit/incoming_matched_cubit.dart';
import 'package:booking_app_mobile/models/incomingMatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constant/values.dart';
import '../../cubit/authentication_cubit.dart';
import 'login.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  List<IncomingMatch> incomingMatchList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<IncomingMatchCubit>(context);
    cubit.getIncomingMatches();

    return BlocBuilder<IncomingMatchCubit, IncomingMatchState>(
      builder: (context, state) {

        if (state is LoadingIncomingMatchesState) {
          return Loading();
        }

        if (state is LoadedIncomingMatchesState) {
          incomingMatchList = state.incomingMatches;
        }

        return buildListView();
      }
    );
  }

  Scaffold buildListView() {
    final cubit = BlocProvider.of<AuthenticationCubit>(context);
    Future<void> handleLogout(BuildContext context) async {
      print("logout");
      //final storage = FlutterSecureStorage();
      //var token = await storage.read(key: JWT_STORAGE_KEY);
      await cubit.logout(JWT_TOKEN_VALUE);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Basketball playground'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                handleLogout(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
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
          Row(
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
          title: Text('Are you sure to cancel this booking?'),
          contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                final cubit = BlocProvider.of<IncomingMatchCubit>(context);
                cubit.cancelMatch(incomingMatch.bookingId);
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                  msg: "Cancel the booking successfully.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color.fromARGB(255, 0, 255, 115),
                  textColor: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16.0
                );
              },
            ),
          ],
        );
      },
    );
  }
}
