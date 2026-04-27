import 'package:flutter/material.dart';
import '../../../../data/models/stock_model.dart';

class StockCard extends StatelessWidget {
  final StockModel stock;

  const StockCard({
    super.key,
    required this.stock,
  });

  String _formatPrice(double price) {
    if (price >= 1000) {
      final parts = price.toStringAsFixed(2).split('.');
      final intPart = parts[0];
      final decPart = parts[1];
      final result = StringBuffer();
      int count = 0;

      for (int i = intPart.length - 1; i >= 0; i--) {
        if (count == 3 && i == intPart.length - 4) {
          result.write(',');
        } else if (count > 3 && (count - 3) % 2 == 0) {
          result.write(',');
        }
        result.write(intPart[i]);
        count++;
      }

      return '${result.toString().split('').reversed.join()}.$decPart';
    }
    return price.toStringAsFixed(2);
  }

  String _formatChange(double change) {
    final formatted = change.abs().toStringAsFixed(2);
    return change >= 0 ? '+$formatted' : '-$formatted';
  }

  String _getExchangeLabel() {
    if (stock.exchange.isEmpty) {
      return stock.instrumentType;
    }
    return '${stock.exchange} | ${stock.instrumentType}';
  }

  @override
  Widget build(BuildContext context) {
    final bool isPositive = stock.change >= 0;
    final Color priceColor =
        isPositive ? const Color(0xFF00C853) : const Color(0xFFD50000);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock.symbol,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _getExchangeLabel(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatPrice(stock.price),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: priceColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_formatChange(stock.change)} (${stock.changePercent.abs().toStringAsFixed(2)}%)',
                style: TextStyle(
                  fontSize: 12,
                  color: priceColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}