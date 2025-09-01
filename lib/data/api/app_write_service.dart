import 'package:appwrite/appwrite.dart';

class AppWriteService {
  late final Client client;
  late final Account account;
  late final Databases database;
  late final Messaging messaging;

  AppWriteService() {
    client =
        Client().setEndpoint('https://cloud.appwrite.io/v1').setProject('67906537001a621d1f53');

    account = Account(client);
    database = Databases(client);
    messaging = Messaging(client);
  }
}
