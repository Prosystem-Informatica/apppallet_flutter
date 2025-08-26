class LoginModel {
  String? codigo;
  String? validado;
  String? empresa;
  String? idplaca;
  String? placa;
  String? equipe;

  LoginModel({
    this.codigo,
    this.validado,
    this.empresa,
    this.idplaca,
    this.placa,
    this.equipe,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    codigo = json['CODIGO'];
    validado = json['VALIDADO'];
    empresa = json['EMPRESA'];
    idplaca = json['ID_PLACA'];
    placa = json['PLACA'];
    equipe = json['EQUIPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CODIGO'] = this.codigo;
    data['VALIDADO'] = this.validado;
    data['EMPRESA'] = this.empresa;
    data['ID_PLACA'] = this.idplaca;
    data['PLACA'] = this.placa;
    data['EQUIPE'] = this.equipe;
    return data;
  }
}
