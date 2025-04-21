import 'package:flutter/material.dart';
import 'build_input_field.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final _formKey = GlobalKey<FormState>();
  bool _mostrarResponsavel = false;
  @override
  Widget build(BuildContext context) {
    return Form(
          key: _formKey,
          child: Column(
            children: [
              BuildInputField('Nome da Empresa'),
              const SizedBox(height: 16),
              BuildInputField('CNPJ'),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _mostrarResponsavel = !_mostrarResponsavel;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 550,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _mostrarResponsavel
                        ? Colors.white10
                        : Colors.transparent,
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _mostrarResponsavel
                        ? 'Esconder Dados do Responsável'
                        : 'Adicionar Dados do Responsável',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _mostrarResponsavel
                    ? Column(
                        key: const ValueKey('responsavel'),
                        children: [
                          const SizedBox(height: 16),
                          BuildInputField('Nome do Responsável'),
                          const SizedBox(height: 16),
                          BuildInputField('Email do Responsável'),
                          const SizedBox(height: 16),
                          BuildInputField('Telefone do Responsável'),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 550,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.purpleAccent.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // salvar os dados
                    }
                  },
                  child: const Text(
                    'Cadastrar Empresa',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white 
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}