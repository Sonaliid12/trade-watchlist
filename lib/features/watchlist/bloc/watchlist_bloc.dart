import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/stock_model.dart';
import '../../watchlist/repository/watchlist_repository.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistRepository repository;

  WatchlistBloc({required this.repository}) : super(const WatchlistInitial()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<SwitchWatchlist>(_onSwitchWatchlist);
    on<ReorderStock>(_onReorderStock);
    on<DeleteStock>(_onDeleteStock);
    on<SaveWatchlist>(_onSaveWatchlist);
  }

  void _onLoadWatchlist(LoadWatchlist event, Emitter<WatchlistState> emit) {
    emit(const WatchlistLoading());
    final stocks = repository.getStocks(event.watchlistName);
    final watchlistNames = repository.getWatchlistNames();
    emit(
      WatchlistLoaded(
        stocks: stocks,
        activeWatchlist: event.watchlistName,
        watchlistNames: watchlistNames,
      ),
    );
  }

  void _onSwitchWatchlist(SwitchWatchlist event, Emitter<WatchlistState> emit) {
    final stocks = repository.getStocks(event.watchlistName);
    final watchlistNames = repository.getWatchlistNames();
    emit(
      WatchlistLoaded(
        stocks: stocks,
        activeWatchlist: event.watchlistName,
        watchlistNames: watchlistNames,
      ),
    );
  }

  void _onReorderStock(ReorderStock event, Emitter<WatchlistState> emit) {
    final currentState = state;
    if (currentState is! WatchlistEditing) return;

    final editedStocks = List<StockModel>.from(currentState.editedStocks);
    final int oldIndex = event.oldIndex;
    int newIndex = event.newIndex;

    if (newIndex > oldIndex) newIndex -= 1;

    final StockModel movedStock = editedStocks.removeAt(oldIndex);
    editedStocks.insert(newIndex, movedStock);

    emit(currentState.copyWith(editedStocks: editedStocks));
  }

  void _onDeleteStock(DeleteStock event, Emitter<WatchlistState> emit) {
    final currentState = state;
    if (currentState is! WatchlistEditing) return;

    final editedStocks = List<StockModel>.from(currentState.editedStocks);
    editedStocks.removeAt(event.index);

    emit(currentState.copyWith(editedStocks: editedStocks));
  }

  void _onSaveWatchlist(SaveWatchlist event, Emitter<WatchlistState> emit) {
    final currentState = state;
    if (currentState is! WatchlistEditing) return;

    repository.updateWatchlist(
      currentState.activeWatchlist,
      currentState.editedStocks,
    );

    emit(
      WatchlistLoaded(
        stocks: currentState.editedStocks,
        activeWatchlist: currentState.activeWatchlist,
        watchlistNames: currentState.watchlistNames,
      ),
    );
  }

  void enterEditMode() {
    final currentState = state;

    if (currentState is WatchlistLoaded) {
      emit(
        WatchlistEditing(
          originalStocks: currentState.stocks,
          editedStocks: List<StockModel>.from(currentState.stocks),
          activeWatchlist: currentState.activeWatchlist,
          watchlistNames: currentState.watchlistNames,
        ),
      );
    } else if (currentState is WatchlistLoading) {
      // wait for loaded state then enter edit
      stream.firstWhere((s) => s is WatchlistLoaded).then((loadedState) {
        final loaded = loadedState as WatchlistLoaded;
        emit(
          WatchlistEditing(
            originalStocks: loaded.stocks,
            editedStocks: List<StockModel>.from(loaded.stocks),
            activeWatchlist: loaded.activeWatchlist,
            watchlistNames: loaded.watchlistNames,
          ),
        );
      });
    }
  }

  void exitEditMode() {
    final currentState = state;
    if (currentState is! WatchlistEditing) return;

    emit(
      WatchlistLoaded(
        stocks: currentState.originalStocks,
        activeWatchlist: currentState.activeWatchlist,
        watchlistNames: currentState.watchlistNames,
      ),
    );
  }
}
