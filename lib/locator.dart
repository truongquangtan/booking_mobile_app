import 'package:booking_app_mobile/service/service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerFactory(() => Service());
}
