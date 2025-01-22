import 'package:appwrite/appwrite.dart';

class AppWriteService {
  late final Client client;
  late final Account account;

  AppWriteService() {
    client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('com.example.remedio_certeiro');

    account = Account(client);
  }
}
