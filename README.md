# Trade Watchlist — 021 Trade Assignment

A Flutter application built as part of the 021 Trade assignment. The app replicates the watchlist screen from the 021 Trade trading application, with the ability to reorder stocks using drag and drop, implemented using the BLoC architecture pattern.

## What this app does

- Displays a watchlist of stocks with live-style price and change data
- Supports multiple watchlists via tabs (Watchlist 1, Watchlist 5, Watchlist 6)
- Long press on any watchlist tab to enter edit mode
- Drag and drop stocks to reorder them in edit mode
- Delete stocks from the watchlist
- Save the new order — main screen reflects the updated order immediately
- Go back without saving — original order is preserved

## Tech Stack

- Flutter 3.38.5
- Dart 3.10.4
- flutter_bloc 8.1.6
- equatable 2.0.5

## Project Structure

lib/
├── data/
│   └── models/
│       └── stock_model.dart
├── features/
│   └── watchlist/
│       ├── bloc/
│       │   ├── watchlist_bloc.dart
│       │   ├── watchlist_event.dart
│       │   └── watchlist_state.dart
│       ├── repository/
│       │   └── watchlist_repository.dart
│       └── presentation/
│           ├── screens/
│           │   ├── watchlist_screen.dart
│           │   └── edit_watchlist_screen.dart
│           └── widgets/
│               ├── stock_card.dart
│               ├── market_ticker_widget.dart
│               └── watchlist_tab_bar.dart
└── main.dart

I went with a feature-first folder structure rather than a layer-first one. Since this is a watchlist feature, everything related to it — bloc, repository, screens, widgets — lives under one feature folder. This makes it easier to scale; if you add an orders feature tomorrow, it gets its own folder with the same structure.

## BLoC Architecture

I have kept the BLoC implementation strictly by the book — events, states, and the bloc class are all in separate files.

**Events** represent user actions:
- `LoadWatchlist` — fired on app start to load initial data
- `SwitchWatchlist` — fired when user taps a different watchlist tab
- `ReorderStock` — fired when user drags a stock to a new position, carries oldIndex and newIndex
- `DeleteStock` — fired when user taps the delete icon
- `SaveWatchlist` — fired when user taps Save Watchlist button

**States** represent what the UI should show:
- `WatchlistInitial` — app just opened
- `WatchlistLoading` — data is being fetched
- `WatchlistLoaded` — main screen, data ready
- `WatchlistEditing` — edit screen, user is reordering
- `WatchlistError` — something went wrong

The most important design decision in the state layer is that `WatchlistEditing` holds two separate lists — `originalStocks` and `editedStocks`. The reason is simple: if the user reorders everything and then goes back without saving, the original order needs to be restored. `editedStocks` is the working copy that updates on every drag, `originalStocks` is the backup.

**Repository** holds the sample data and exposes three methods — `getStocks`, `updateWatchlist`, and `deleteStock`. The repository is injected into the BLoC via constructor, keeping the BLoC independent of the data source. If the data source changes to an API tomorrow, only the repository needs to change.

## Data Structure

Stocks are stored as a `Map<String, List<StockModel>>` where the key is the watchlist name and the value is the ordered list of stocks for that watchlist. This makes switching between watchlists a simple map lookup.

```dart
final Map<String, List<StockModel>> _watchlists = {
  'Watchlist 1': [...],
  'Watchlist 5': [],
  'Watchlist 6': [],
};
```

## How the reorder works

Flutter's `ReorderableListView` handles the drag and drop UI. It gives us `oldIndex` and `newIndex` on every reorder. One thing worth noting — Flutter internally adds 1 to `newIndex` when dragging downward, so we subtract 1 before inserting to get the correct position.

```dart
if (newIndex > oldIndex) newIndex -= 1;
final StockModel moved = editedStocks.removeAt(oldIndex);
editedStocks.insert(newIndex, moved);
```

## How to run

```bash
git clone https://github.com/Sonaliid12/trade-watchlist.git
cd trade_watchlist
flutter pub get
flutter run
```

Tested on Flutter 3.38.5 and Dart 3.10.4.

## Screens

| Main Watchlist | Edit Watchlist |
|---|---|
| Shows stock list with price and change data | Drag and drop to reorder, delete stocks |
