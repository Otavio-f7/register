import 'package:flutter/material.dart';
import 'package:register/model/new_client.dart';
import 'package:register/services/send_mail_service.dart';
import 'build_input_field.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {

  final _formKey = GlobalKey<FormState>();
  bool _mostrarResponsavel = false;

  final _nameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _responsibleNameController = TextEditingController();
  final _responsibleEmaiController = TextEditingController();
  final _responsiblePhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
          key: _formKey,
          child: Column(
            children: [
              BuildInputField('Nome da Empresa', controller: _nameController,),
              const SizedBox(height: 16),
              BuildInputField('CNPJ', controller: _cnpjController,),
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
                          BuildInputField('Nome do Responsável', controller: _responsibleNameController,),
                          const SizedBox(height: 16),
                          BuildInputField('Email do Responsável', controller: _responsibleEmaiController),
                          const SizedBox(height: 16),
                          BuildInputField('Telefone do Responsável', controller: _responsiblePhoneController),
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
                      final newClient = _mostrarResponsavel
                      ? NewClient(
                          name: _nameController.text,
                          cnpj: _cnpjController.text,
                          responsibleName: _responsibleNameController.text,
                          responsibleEmail: _responsibleEmaiController.text,
                          responsiblephone: _responsiblePhoneController.text,
                        )
                      : NewClient.unresponsible(
                          name: _nameController.text,
                          cnpj: _cnpjController.text,
                        );
                      SendMailService().sendMail(newClient);
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