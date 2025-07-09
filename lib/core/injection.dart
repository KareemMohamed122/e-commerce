import 'package:get_it/get_it.dart';
import 'package:untitled2/bloc/cart/cart_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<CartBloc>(() => CartBloc());
}
