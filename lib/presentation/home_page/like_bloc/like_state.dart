import 'package:equatable/equatable.dart';

class LikeState extends Equatable {
  final List<String>? likedIds;

  const LikeState({required this.likedIds});

  LikeState copyWith({List<String>? likedIds}) {
    return LikeState(
      likedIds: likedIds ?? this.likedIds,
    );
  }

  @override
  List<Object?> get props => [likedIds];
}