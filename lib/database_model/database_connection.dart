import 'package:mysql1/mysql1.dart';

class Mysql {
    static String host = 'cinemates-database.cvtkh0bf6amk.us-east-2.rds.amazonaws.com',
                  user = 'admin',
                  password = 'password',
                  db = 'cinemates_database';
    static int port = 3306;

    Mysql();

    Future<MySqlConnection> getConnection() async {
      var settings = new ConnectionSettings(
        host: host,
        user: user,
        password: password,
        port: port,
        db: db
      );
      return await MySqlConnection.connect(settings);
    }

}