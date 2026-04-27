import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/watchlist_bloc.dart';
import '../../bloc/watchlist_event.dart';
import '../../bloc/watchlist_state.dart';
import '../widgets/stock_card.dart';
import '../widgets/market_ticker_widget.dart';
import '../widgets/watchlist_tab_bar.dart';
import 'edit_watchlist_screen.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is WatchlistLoaded) {
              return _buildLoadedScreen(context, state);
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildLoadedScreen(BuildContext context, WatchlistLoaded state) {
    return Column(
      children: [
        _buildMarketTicker(),
        _buildSearchBar(),
        WatchlistTabBar(
          watchlistNames: state.watchlistNames,
          activeWatchlist: state.activeWatchlist,
          onTabSelected: (name) {
            context.read<WatchlistBloc>().add(SwitchWatchlist(name));
          },
          onTabLongPressed: (name) async {
            context.read<WatchlistBloc>().add(SwitchWatchlist(name));
            
            await Future.delayed(const Duration(milliseconds: 100));
            
            if (context.mounted) {
              context.read<WatchlistBloc>().enterEditMode();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<WatchlistBloc>(),
                    child: const EditWatchlistScreen(),
                  ),
                ),
              );
            }
          },
        ),
        _buildSortByButton(),
        Expanded(
          child: ListView.builder(
            itemCount: state.stocks.length,
            itemBuilder: (context, index) {
              return StockCard(stock: state.stocks[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMarketTicker() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: MarketTickerWidget(
              item: const MarketTickerItem(
                name: 'SENSEX 18TH SEP 8...',
                exchange: 'BSE',
                price: 1225.55,
                change: 144.50,
                changePercent: 13.3,
              ),
            ),
          ),
          Expanded(
            child: MarketTickerWidget(
              item: const MarketTickerItem(
                name: 'NIFTY BANK',
                exchange: '',
                price: 54170.15,
                change: -16.75,
                changePercent: -0.03,
              ),
              showDivider: true,
              showArrow: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Color(0xFF9E9E9E), size: 20),
          SizedBox(width: 10),
          Text(
            'Search for instruments',
            style: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
          ),
        ],
      ),
    );
  }

  Widget _buildSortByButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.tune, size: 16, color: Color(0xFF1A1A1A)),
              SizedBox(width: 6),
              Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1A1A1A),
        unselectedItemColor: const Color(0xFF9E9E9E),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'GTT+'),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Funds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
