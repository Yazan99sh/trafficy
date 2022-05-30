import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:injectable/injectable.dart';
import 'consts/urls.dart';

@injectable
class AppwriteDartApi {
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

  Users getUsers() {
    var client = getClient();
    client.setKey(
        '1c4cfef63c61f3cff2066f1947a09f3edd7fb1ade8ed39844f445e58fee5d06213c9480728e98db4e751568695c62c223ecc958c16ce9ba6724601d481ad56a868ccbcb9d683832fd461fed58c1351975548e4ee2c84e5660f85a9797c8569d79fb1ad1466faf52cc9b267dbda05d5c57f67100225f216ef9a39843df3a51023');
    Users users = Users(client);
    return users;
  }

  Future<User> getUserById(String id) async {
    Users users = getUsers();
    return await users.get(userId: id);
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
}
