import 'package:equatable/equatable.dart';
import '../../../data/models/stock_model.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

class WatchlistInitial extends WatchlistState {
  const WatchlistInitial();
}

class WatchlistLoading extends WatchlistState {
  const WatchlistLoading();
}

class WatchlistLoaded extends WatchlistState {
  final List<StockModel> stocks;
  final String activeWatchlist;
  final List<String> watchlistNames;

  const WatchlistLoaded({
    required this.stocks,
    required this.activeWatchlist,
    required this.watchlistNames,
  });

  WatchlistLoaded copyWith({
    List<StockModel>? stocks,
    String? activeWatchlist,
    List<String>? watchlistNames,
  }) {
    return WatchlistLoaded(
      stocks: stocks ?? this.stocks,
      activeWatchlist: activeWatchlist ?? this.activeWatchlist,
      watchlistNames: watchlistNames ?? this.watchlistNames,
    );
  }

  @override
  List<Object?> get props => [stocks, activeWatchlist, watchlistNames];
}

class WatchlistEditing extends WatchlistState {
  final List<StockModel> originalStocks;
  final List<StockModel> editedStocks;
  final String activeWatchlist;
  final List<String> watchlistNames;

  const WatchlistEditing({
    required this.originalStocks,
    required this.editedStocks,
    required this.activeWatchlist,
    required this.watchlistNames,
  });

  WatchlistEditing copyWith({
    List<StockModel>? originalStocks,
    List<StockModel>? editedStocks,
    String? activeWatchlist,
    List<String>? watchlistNames,
  }) {
    return WatchlistEditing(
      originalStocks: originalStocks ?? this.originalStocks,
      editedStocks: editedStocks ?? this.editedStocks,
      activeWatchlist: activeWatchlist ?? this.activeWatchlist,
      watchlistNames: watchlistNames ?? this.watchlistNames,
    );
  }

  @override
  List<Object?> get props => [
        originalStocks,
        editedStocks,
        activeWatchlist,
        watchlistNames,
      ];
}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}