import 'package:booking_app_mobile/common_components/loading.dart';
import 'package:booking_app_mobile/constant/values.dart';
import 'package:booking_app_mobile/cubit/yard_list_cubit.dart';
import 'package:booking_app_mobile/cubit/yard_list_static_cubit.dart';
import 'package:booking_app_mobile/models/yard_simple.dart';
import 'package:booking_app_mobile/widgets/yard_card.dart';
import 'package:booking_app_mobile/widgets/district_province_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../content_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<YardSimple> yards = [];

  @override
  void initState(){
    super.initState();
    //readJson();
  }

  // Future<void> readJson() async {
  //   final String response =
  //       await rootBundle.loadString('assets/sampleYardSimple.json');
    
  //   final data = await json.decode(response);
  //   setState(() {
  //     yards = data.map((dataMap) => YardSimple.fromJson(dataMap)).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return buildHomePage();
  }

  Widget buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basketball playground'),
        actions: <Widget>[
          IconButton(onPressed: () {

          }, icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              const Text('Welcome...', style: headerStyle),
              const SizedBox(height: 10),
              const ContentTitle(title: 'Top Rating Yards'),
              SizedBox(
                height: 10,
              ),
              buildStaticYardList(),
              const ContentTitle(title: 'All Yards'),
              DistrictProvinceSelection(key: UniqueKey(),),
              SizedBox(
                height: 10,
              ),
              buildYardList(),
            ],
          ),
        ),
      ),
    );
  }

   Widget buildStaticYardList() {
    final yardListStaticCubit = BlocProvider.of<YardListStaticCubit>(context);
    yardListStaticCubit.getYardList(null, null);

    return BlocBuilder<YardListStaticCubit, YardListStaticState>(
      builder: (context, state){
        if(state is LoadingYardListStaticState) {
          return Loading();
        }
        if(state is LoadedYardListStaticState) {
          yards = state.yards;
        }

        return Column(
          children: [
            SizedBox(
              height: 350,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: yards.length,
                itemBuilder: (BuildContext context, int index) {
                  return YardCard(yard: yards[index]);
                },
              ),
            ),
          ],
        );
      }
    );
  }

  Widget buildYardList() {
    final yardListCubit = BlocProvider.of<YardListCubit>(context);
    yardListCubit.getYardList(null, null);

    return BlocBuilder<YardListCubit, YardListState>(
      builder: (context, state){
        if(state is LoadingYardListState) {
          return Loading();
        }
        if(state is LoadedYardListState) {
          yards = state.yards;
        }

        return Column(
          children: [
            SizedBox(
              height: 350,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: yards.length,
                itemBuilder: (BuildContext context, int index) {
                  return YardCard(yard: yards[index]);
                },
              ),
            ),
          ],
        );
      }
    );
  }
}
