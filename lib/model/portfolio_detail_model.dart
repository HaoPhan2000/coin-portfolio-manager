class PortfolioDetailModel {
  PortfolioDetailModel({
    required this.id,
    required this.idCoinFromDB,
    required this.name,
    required this.symbol,
    required this.image,
    required this.price,
    required this.priceChange,
    required this.soLuongConLai,
    required this.valueCoin,
    required this.giaMuaTrungBinh,
    required this.pnl,
    required this.percentPnl,
  });

  late String id;
  late String idCoinFromDB;
  late String name;
  late String symbol;
  late String image;
  late num price;
  late num priceChange;
  late num soLuongConLai;
  late num valueCoin;
  late num giaMuaTrungBinh;
  late num pnl;
  late num percentPnl;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['_id'] = idCoinFromDB;
    data['name'] = name;
    data['symbol'] = symbol;
    data['image'] = image;
    data['current_price'] = price;
    data['price_change_24h'] = priceChange;
    data['valueCoin'] = valueCoin;
    data['soLuong'] = soLuongConLai;
    return data;
  }
}
