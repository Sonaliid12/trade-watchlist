import '../../../data/models/stock_model.dart';

class WatchlistRepository {
  final Map<String, List<StockModel>> _watchlists = {
    'Watchlist 1': [
      const StockModel(
        symbol: 'RELIANCE',
        exchange: 'NSE',
        instrumentType: 'EQ',
        price: 1374.10,
        change: -4.40,
        changePercent: -0.32,
      ),
      const StockModel(
        symbol: 'HDFCBANK',
        exchange: 'NSE',
        instrumentType: 'EQ',
        price: 966.85,
        change: 0.85,
        changePercent: 0.09,
      ),
      const StockModel(
        symbol: 'ASIANPAINT',
        exchange: 'NSE',
        instrumentType: 'EQ',
        price: 2537.40,
        change: 6.60,
        changePercent: 0.26,
      ),
      const StockModel(
        symbol: 'NIFTY IT',
        exchange: '',
        instrumentType: 'IDX',
        price: 35187.30,
        change: 876.86,
        changePercent: 2.56,
      ),
      const StockModel(
        symbol: 'RELIANCE SEP 1880 CE',
        exchange: 'NSE',
        instrumentType: 'Monthly',
        price: 0.00,
        change: 0.00,
        changePercent: 0.00,
      ),
      const StockModel(
        symbol: 'RELIANCE SEP 1370 PE',
        exchange: 'NSE',
        instrumentType: 'Monthly',
        price: 19.20,
        change: 1.00,
        changePercent: 5.49,
      ),
      const StockModel(
        symbol: 'MRF',
        exchange: 'NSE',
        instrumentType: 'EQ',
        price: 147625.00,
        change: 550.00,
        changePercent: 0.37,
      ),
      const StockModel(
        symbol: 'MRF',
        exchange: 'BSE',
        instrumentType: 'EQ',
        price: 147439.45,
        change: 463.80,
        changePercent: 0.32,
      ),
    ],
    'Watchlist 5': [],
    'Watchlist 6': [],
  };

  List<StockModel> getStocks(String watchlistName) {
    return List.from(_watchlists[watchlistName] ?? []);
  }

  List<String> getWatchlistNames() {
    return _watchlists.keys.toList();
  }

  void updateWatchlist(String watchlistName, List<StockModel> stocks) {
    _watchlists[watchlistName] = stocks;
  }

  void deleteStock(String watchlistName, int index) {
    _watchlists[watchlistName]?.removeAt(index);
  }
}