class HomeModel {
  String? totalViagens;
  String? viagensNormal;
  String? viagensExtra;
  String? totalDev;

  HomeModel({
    this.totalViagens,
    this.viagensNormal,
    this.viagensExtra,
    this.totalDev,
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    totalViagens = json['TOTAL_VIAGENS'];
    viagensNormal = json['VIAGENS_NORMAL'];
    viagensExtra = json['VIAGENS_EXTRA'];
    totalDev = json['TOTAL_DEV'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TOTAL_VIAGENS'] = totalViagens;
    data['VIAGENS_NORMAL'] = viagensNormal;
    data['VIAGENS_EXTRA'] = viagensExtra;
    data['TOTAL_DEV'] = totalDev;
    return data;
  }
}
