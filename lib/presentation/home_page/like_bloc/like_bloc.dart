import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'like_event.dart';
import 'like_state.dart';

const String _likedBoxKey = 'liked';
const String _boxName = 'likesBox';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc() : super(const LikeState(likedIds: [])) {
    on<LoadLikesEvent>(_onLoadLikes);
    on<ChangeLikeEvent>(_onChangeLike);
  }

  Box<List<String>> get _box => Hive.box<List<String>>(_boxName);

  Future<void> _onLoadLikes(
      LoadLikesEvent event,
      Emitter<LikeState> emit,
      ) async {
    final data = _box.get(_likedBoxKey, defaultValue: <String>[]) ?? <String>[];
    emit(state.copyWith(likedIds: List<String>.from(data)));
  }

  Future<void> _onChangeLike(
      ChangeLikeEvent event,
      Emitter<LikeState> emit,
      ) async {
    final updatedList = List<String>.from(state.likedIds ?? []);

    if (updatedList.contains(event.id)) {
      updatedList.remove(event.id);
    } else {
      updatedList.add(event.id);
    }

    await _box.put(_likedBoxKey, updatedList);
    emit(state.copyWith(likedIds: updatedList));
  }
}