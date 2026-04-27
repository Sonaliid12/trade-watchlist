import 'package:equatable/equatable.dart';

class StockModel extends Equatable {
  final String symbol;
  final String exchange;
  final String instrumentType;
  final double price;
  final double change;
  final double changePercent;

  const StockModel({
    required this.symbol,
    required this.exchange,
    required this.instrumentType,
    required this.price,
    required this.change,
    required this.changePercent,
  });

  StockModel copyWith({
    String? symbol,
    String? exchange,
    String? instrumentType,
    double? price,
    double? change,
    double? changePercent,
  }) {
    return StockModel(
      symbol: symbol ?? this.symbol,
      exchange: exchange ?? this.exchange,
      instrumentType: instrumentType ?? this.instrumentType,
      price: price ?? this.price,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
    );
  }

  @override
  List<Object?> get props => [
        symbol,
        exchange,
        instrumentType,
        price,
        change,
        changePercent,
      ];
}