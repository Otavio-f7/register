import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BuildInputField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  const BuildInputField(
    this.label, 
    {super.key,
    this.controller,});

  String? validateCNPJ(String? cnpj) {
    if (cnpj == null || cnpj.isEmpty) {
      return 'O CNPJ é obrigatório.';
    }

    // Remove caracteres não numéricos
    final justNumbers = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

    // Verifica se a string tem 14 dígitos
    if (justNumbers.length != 14) {
      return 'O CNPJ deve ter 14 dígitos.';
    }

    // Verifica se todos os dígitos são iguais (CNPJ inválido)
    if (RegExp(r'^(\d)\1+$').hasMatch(justNumbers)) {
      return 'CNPJ inválido.';
    }

    // Algoritmo de validação
    List<int> weightFirstDigits = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    List<int> weightSecondDigits = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

    int calcularDigito(String numeros, List<int> pesos) {
      int sum = 0;
      for (int i = 0; i < pesos.length; i++) {
        sum += int.parse(numeros[i]) * pesos[i];
      }
      int rest  = sum % 11;
      return rest  < 2 ? 0 : 11 - rest ;
    }

    final firstTwelveDigits = justNumbers.substring(0, 12);
    final firstCheckerDigit = int.parse(justNumbers[12]);
    final secondCheckerDigit = int.parse(justNumbers[13]);

    if (calcularDigito(firstTwelveDigits, weightFirstDigits) != firstCheckerDigit) {
      return 'CNPJ inválido.';
    }
    final firstThirteenDigits = justNumbers.substring(0, 13);
    if (calcularDigito(firstThirteenDigits, weightSecondDigits) != secondCheckerDigit) {
      return 'CNPJ inválido.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    final List<MaskTextInputFormatter> formatters = [];
    if (label == 'CNPJ') {
      formatters.add(MaskTextInputFormatter(
        mask: '##.###.###/####-##',
        filter: {"#": RegExp(r'[0-9]')},
      ));
      // formatters.add(LengthLimitingTextInputFormatter(18));
    }
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white10,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
      inputFormatters: formatters,
      validator: (value) {
        if (label == 'CNPJ') {
         return validateCNPJ(value);          
        } else if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }
}