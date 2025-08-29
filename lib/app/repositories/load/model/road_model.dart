class RoadModel {
  String? id;
  String? data;
  String? idVeiculo;
  String? placa;
  String? quant;
  String? quantDv;

  RoadModel({
    this.id,
    this.data,
    this.idVeiculo,
    this.placa,
    this.quant,
    this.quantDv,
  });

  RoadModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    data = json['DATA'];
    idVeiculo = json['ID_VEICULO'];
    placa = json['PLACA'];
    quant = json['QUANT'];
    quantDv = json['QUANTDV'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['ID'] = id;
    dataMap['DATA'] = data;
    dataMap['ID_VEICULO'] = idVeiculo;
    dataMap['PLACA'] = placa;
    dataMap['QUANT'] = quant;
    dataMap['QUANTDV'] = quantDv;
    return dataMap;
  }
}
