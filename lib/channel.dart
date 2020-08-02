import 'package:my_app/controller/word_controller.dart';

import 'my_app.dart';

class MyAppChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = WordConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final database = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);
    context = ManagedContext(dataModel, database);
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route('/words').link(() => WordController(context));
    router.route("/words/add-word").link(() => WordController(context));
    router.route("/words/update-word/[:id]").link(() => WordController(context));
    router.route("/words/delete-word/[:id]").link(() => WordController(context));
    return router;
  }
}

class WordConfig extends Configuration {
  WordConfig(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}
