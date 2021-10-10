import 'package:mysql1/mysql1.dart';

class DatabaseConnection {

  MySqlConnection conn;

  DatabaseConnection();

  DatabaseConnection._privateConstructor();

  static final DatabaseConnection instance = DatabaseConnection._privateConstructor();

  Future<void> initConnection() async {
    this.conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'cinemates-db.cvtkh0bf6amk.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'root',
        db: 'cinemates_db',
        password: 'cinemates123'));
  }
}
