import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  // Substitua pelos seus dados
  String username = ''; // Seu e-mail
  String password = ''; // Sua senha ou app password (para Gmail)

  // Configura o servidor SMTP (exemplo com Gmail)
  final smtpServer = gmail(username, password);

  // Criação do e-mail
  final message = Message()
    ..from = Address(username, '') // Remetente
    ..recipients.add('') // Destinatário
    ..subject = 'Teste de E-mail' // Assunto
    ..text = 'Enviando um email através de um código dart, sem dotenv.';

  try {
    // Envio do e-mail
    final sendReport = await send(message, smtpServer);
    print('E-mail enviado com sucesso: ${sendReport.toString()}');
  } catch (e) {
    print('Falha ao enviar o e-mail: $e');
  }
}
