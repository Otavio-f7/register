class NewClient {
  final String name;
  final String cnpj;
  final String responsibleName;
  final String responsibleEmail;
  final String responsiblephone;

  const NewClient({
    required this.name, 
    required this.cnpj, 
    required this.responsibleName, 
    required this.responsibleEmail, 
    required this.responsiblephone
  });

  const NewClient.unresponsible({
    required this.name, 
    required this.cnpj, 
    this.responsibleName = 'Não informado', 
    this.responsibleEmail = 'Não informado', 
    this.responsiblephone = 'Não informado',
  });

   Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cnpj': cnpj,
      'responsibleName': responsibleName,
      'responsibleEmail': responsibleEmail,
      'responsiblephone': responsiblephone,
    };
  }
}