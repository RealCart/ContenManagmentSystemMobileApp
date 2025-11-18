import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocEx on Bloc {
  void addAll(Iterable event) {
    for (final event in event) {
      add(event);
    }
  }
}
