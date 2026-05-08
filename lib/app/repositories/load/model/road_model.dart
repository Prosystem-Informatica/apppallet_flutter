class RoadModel {
  String? id;
  String? data;
  String? idVeiculo;
  String? placa;
  String? quant;
  String? quantDv;
  String? quantMax;
  String? saldo;

  RoadModel({
    this.id,
    this.data,
    this.idVeiculo,
    this.placa,
    this.quant,
    this.quantDv,
    this.quantMax,
    this.saldo,
  });

  RoadModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    data = json['DATA'];
    idVeiculo = json['ID_VEICULO'];
    placa = json['PLACA'];
    quant = json['QUANT'];
    quantDv = json['QUANTDV'];
    quantMax = json['QTDMAX'];
    saldo = json['SALDO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['ID'] = id;
    dataMap['DATA'] = data;
    dataMap['ID_VEICULO'] = idVeiculo;
    dataMap['PLACA'] = placa;
    dataMap['QUANT'] = quant;
    dataMap['QUANTDV'] = quantDv;
    dataMap['QTDMAX'] = quantMax;
    dataMap['SALDO'] = saldo;
    return dataMap;
  }
}
