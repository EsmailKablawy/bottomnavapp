import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import '../data/repo/main_repo.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final MainRepo _repo;
  MainCubit(this._repo) : super(const MainState.initial());
  bool update = false;
  ValueNotifier<int> currentIndex = ValueNotifier(0);
}
