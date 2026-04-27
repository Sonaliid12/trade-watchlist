import 'package:equatable/equatable.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWatchlist extends WatchlistEvent {
  final String watchlistName;

  const LoadWatchlist(this.watchlistName);

  @override
  List<Object?> get props => [watchlistName];
}

class SwitchWatchlist extends WatchlistEvent {
  final String watchlistName;

  const SwitchWatchlist(this.watchlistName);

  @override
  List<Object?> get props => [watchlistName];
}

class ReorderStock extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderStock({
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class DeleteStock extends WatchlistEvent {
  final int index;

  const DeleteStock(this.index);

  @override
  List<Object?> get props => [index];
}

class SaveWatchlist extends WatchlistEvent {
  const SaveWatchlist();
}