class HomeModel {
  String? totalviagens;
  String? viagenssnormal;
  String? viagenssextra;
  String? totaldev;

  HomeModel(
      {this.totalviagens,
        this.viagenssnormal,
        this.viagenssextra,
        this.totaldev});

  HomeModel.fromJson(Map<String, dynamic> json) {
    totalviagens = json['TOTAL_VIAGENS'];
    viagenssnormal = json['VIAGENS_NORMAL'];
    viagenssextra = json['VIAGENS_EXTRA'];
    totaldev = json['TOTAL_DEV'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TOTAL_VIAGENS'] = this.totalviagens;
    data['VIAGENS_NORMAL'] = this.viagenssnormal;
    data['VIAGENS_EXTRA'] = this.viagenssextra;
    data['TOTAL_DEV'] = this.totaldev;
    return data;
  }
}