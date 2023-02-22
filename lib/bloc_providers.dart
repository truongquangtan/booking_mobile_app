import 'package:booking_app_mobile/cubit/yard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  BlocProviders._();

  static get getProviders => [
        BlocProvider(create: (_) => YardCubit()),
      ];
}
