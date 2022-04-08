import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:injectable/injectable.dart';
import 'consts/urls.dart';

@injectable
class AppwriteApi {
  Client getClient() {
    Client client = Client();
    client
        .setEndpoint(Urls.APPWRITE_ENDPOINT)
        .setProject(Urls.APPWRITE_PROJECTID);
    return client;
  }

  Account getAccount() {
    var client = getClient();
    Account account = Account(client);
    return account;
  }

  Future<User> getUser() async {
    var account = getAccount();
    User user = await account.get();
    return user;
  }

  Database getDataBase() {
    var client = getClient();
    Database database = Database(client);
    return database;
  }

  Realtime getRealTime() {
    var client = getClient();
    var realtime = Realtime(client);
    return realtime;
  }
}
