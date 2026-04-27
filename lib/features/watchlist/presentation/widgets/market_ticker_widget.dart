import 'package:flutter/material.dart';

class MarketTickerItem {
  final String name;
  final String exchange;
  final double price;
  final double change;
  final double changePercent;

  const MarketTickerItem({
    required this.name,
    required this.exchange,
    required this.price,
    required this.change,
    required this.changePercent,
  });
}

class MarketTickerWidget extends StatelessWidget {
  final MarketTickerItem item;
  final bool showDivider;
  final bool showArrow;

  const MarketTickerWidget({
    super.key,
    required this.item,
    this.showDivider = false,
    this.showArrow = false,
  });

  String _formatPrice(double price) {
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

  @override
  Widget build(BuildContext context) {
    final bool isPositive = item.change >= 0;
    final Color changeColor =
        isPositive ? const Color(0xFF00C853) : const Color(0xFFD50000);

    return Row(
      children: [
        if (showDivider)
          Container(
            width: 1,
            height: 40,
            color: const Color(0xFFEEEEEE),
            margin: const EdgeInsets.only(right: 16),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (item.exchange.isNotEmpty)
                    Text(
                      item.exchange,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  if (showArrow)
                    const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: Color(0xFF9E9E9E),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    _formatPrice(item.price),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${item.change >= 0 ? '' : '-'}${item.change.abs().toStringAsFixed(2)} (${item.changePercent.abs().toStringAsFixed(2)}...)',
                    style: TextStyle(
                      fontSize: 12,
                      color: changeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
} 