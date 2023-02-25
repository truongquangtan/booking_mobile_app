import 'package:booking_app_mobile/cubit/districts_provinces_cubit.dart';
import 'package:booking_app_mobile/cubit/incoming_matched_cubit.dart';
import 'package:booking_app_mobile/cubit/yard_cubit.dart';
import 'package:booking_app_mobile/cubit/yard_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  BlocProviders._();

  static get getProviders => [
        BlocProvider(create: (_) => YardCubit()),
        BlocProvider(create: (_) => DistrictAndProvinceCubit()),
        BlocProvider(create: (_) => YardListCubit()),
        BlocProvider(create: (_) => IncomingMatchCubit()),
      ];
}
