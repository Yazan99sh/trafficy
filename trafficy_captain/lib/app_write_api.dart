import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:injectable/injectable.dart';
import 'consts/urls.dart';

@injectable
class AppwriteApi {
  Future<Client> getClient() async {
    Client client = Client();
    client
        .setEndpoint(Urls.APPWRITE_ENDPOINT)
        .setProject(Urls.APPWRITE_PROJECTID);
    return client;
  }

  Future<Account> getAccount() async {
    var client = await getClient();
    Account account = Account(client);
    return account;
  }

  Future<User> getUser() async {
    var account = await getAccount();
    User user = await account.get();
    return user;
  }

  Future<Database> getDataBase() async {
    var client = await getClient();
    Database database = Database(client);
    return database;
  }
}
