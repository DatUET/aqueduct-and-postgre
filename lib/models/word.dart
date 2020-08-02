import 'package:my_app/my_app.dart';

class Word extends ManagedObject<_Word> implements _Word {

}

class _Word {
  @primaryKey
  int id;

  @Column(unique: true, indexed: true)
  String word;

  Document content;

}