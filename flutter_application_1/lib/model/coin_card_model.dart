class CoinCard {
  late final String id;
  late String name;
  late String symbol;
  late String image;
  late num price;
  late num priceChange;
  late num changePercentage;
  late num marketCapRank;
  late num? marketCap;//
  late num? fullyMarketCap;//
  late num? totalVolume;
  late num high24h;//
  late num low24h;//
  late num? supply;
  late num? maxSupply;
  CoinCard({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.price,
    required this.priceChange,
    required this.changePercentage,
    required this.marketCapRank,
    required this.marketCap,
    required this.fullyMarketCap,
    required this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.supply,
    required this.maxSupply,
  });

  CoinCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    image = json['image'];
    price = json['current_price'];
    priceChange = json['price_change_24h'];
    changePercentage = json['price_change_percentage_24h'];
    marketCapRank = json['market_cap_rank'];
    marketCap = json['market_cap'];
    fullyMarketCap = json['fully_diluted_valuation'];
    totalVolume = json['total_volume'];
    high24h = json['high_24h'];
    low24h = json['low_24h'];
    supply = json['circulating_supply'];
    maxSupply = json['max_supply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['symbol'] = symbol;
    data['image'] = image;
    data['current_price'] = price;
    data['price_change_24h'] = priceChange;
    data['price_change_percentage_24h'] = changePercentage;
    data['market_cap_rank'] = marketCapRank;
    data['market_cap'] = marketCap;
    data['fully_diluted_valuation'] = fullyMarketCap;
    data['total_volume'] = totalVolume;
    data['high_24h'] = high24h;
    data['low_24h'] = low24h;
    data['circulating_supply'] = supply;
    data['max_supply'] = maxSupply;
    return data;
  }
}
