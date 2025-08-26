import 'package:apppallet_flutter/app/core/ui/helpers/messages.dart';
import 'package:flutter/material.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({super.key});

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> with Messages<LoadPage> {
  final _formKey = GlobalKey<FormState>();

  final cargaController = TextEditingController();
  final placaController = TextEditingController();
  final nomeController = TextEditingController();
  final entregaController = TextEditingController();
  final devolucaoController = TextEditingController();

  bool entrega = false;
  bool devolucao = false;

  String? fotoPath;
  final String dataAtual =
      "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}";

  @override
  void dispose() {
    cargaController.dispose();
    placaController.dispose();
    nomeController.dispose();
    entregaController.dispose();
    devolucaoController.dispose();
    super.dispose();
  }

  void _gravar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dados gravados com sucesso!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Carga"),
        backgroundColor: colorScheme.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  enabled: false,
                  initialValue: dataAtual,
                  decoration: const InputDecoration(
                    labelText: "Data",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: cargaController,
                  decoration: const InputDecoration(
                    labelText: "Nº Carga",
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? "Informe o Nº da carga"
                              : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: placaController,
                  decoration: const InputDecoration(
                    labelText: "Placa",
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? "Informe a placa"
                              : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: "Nome",
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? "Informe o nome"
                              : null,
                ),
                const SizedBox(height: 16),

                /// ENTREGA E DEVOLUÇÃO (numéricos)
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: entregaController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Entrega",
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? "Informe a entrega"
                                    : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: devolucaoController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Devolução",
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? "Informe a devolução"
                                    : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        fotoPath ?? "Nenhuma foto selecionada",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, size: 28),
                      onPressed: () {
                        setState(() {
                          fotoPath = "foto_exemplo.jpg";
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _gravar,
                    child: const Text(
                      "GRAVAR",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
