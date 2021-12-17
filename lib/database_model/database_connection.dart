import 'package:mysql1/mysql1.dart';

class DatabaseConnection {

  MySqlConnection conn;

  DatabaseConnection();

  DatabaseConnection._privateConstructor();

  static final DatabaseConnection instance = DatabaseConnection._privateConstructor();

  Future<void> initConnection() async {
    this.conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'cinemates-db.coh7z9zsf7dm.eu-west-1.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'cinemates_db',
        password: 'cinemates12345'));
  }
}
