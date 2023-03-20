import 'package:booking_app_mobile/cubit/authentication_cubit.dart';
import 'package:booking_app_mobile/cubit/booking_slot_cubit.dart';
import 'package:booking_app_mobile/cubit/districts_provinces_cubit.dart';
import 'package:booking_app_mobile/cubit/incoming_matched_cubit.dart';
import 'package:booking_app_mobile/cubit/slots_cubit.dart';
import 'package:booking_app_mobile/cubit/yard_cubit.dart';
import 'package:booking_app_mobile/cubit/yard_list_cubit.dart';
import 'package:booking_app_mobile/service/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  BlocProviders._();
  static get getProviders => [
        BlocProvider(create: (_) => YardCubit()),
        BlocProvider(create: (_) => DistrictAndProvinceCubit()),
        BlocProvider(create: (_) => YardListCubit()),
        BlocProvider(create: (_) => IncomingMatchCubit()),
        BlocProvider(create: (_) => SlotsCubit()),
        BlocProvider(create: (_) => BookingSlotsCubit()),
        BlocProvider(create: (_) => AuthenticationCubit(userService: UserService(apiUrl: 'https://d2bawuzpgqlp7v.cloudfront.net/api/v1', jwtSecret: 'my_secret_key'))),
      ];
}
