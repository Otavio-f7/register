import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:register/model/new_client.dart';

class SendMailService {

  final gmailSmtp = gmail(dotenv.env["GMAIL_MAIL"]!, dotenv.env["GMAIL_PASSWORD"]!);


  Future<void> sendMail(NewClient client) async {
    String emailMessage = """
    Novo cliente cadastrado com os Seguintes dados:

    Nome do cliente: ${client.name}
    CNPJ do cliente: ${client.cnpj}
    Nome do responsavel: ${client.responsibleName}
    Email do responsavel: ${client.responsibleEmail}
    Telefone do responsavel: ${client.responsiblephone}

    Att.
    Equipe AZSHIP
    """;

    final message = Message()
    ..from = Address(dotenv.env["GMAIL_MAIL"]!, 'Time AzShip')
    ..recipients.addAll(['otavio.azship@gmail.com', 'suporte4@azship.com.br'])
    ..subject = 'Novo Cliente Cadastrado'
    ..text = emailMessage;

    try{
      final sendReport = await send(message, gmailSmtp);
      print(emailMessage);
    } on MailerException catch (e){
      print('Message not sent.');
      for(var p in e.problems){
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}