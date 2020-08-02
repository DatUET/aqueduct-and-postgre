import 'dart:convert';

import 'package:my_app/my_app.dart';
import 'package:my_app/models/word.dart';

class WordController extends ResourceController {
  ManagedContext context;

  WordController(this.context);

  @Operation.get()
  Future<Response> getAllWord() async {
    final query = Query<Word>(context);
    final wordList = await query.fetch();
    return Response.ok(wordList);
  }
  
  @Operation.get('id')
  Future<Response> getWordById(@Bind.path('id') int id) async {
    final query = Query<Word>(context)..where((x) => x.id).equalTo(id);
    final word = await query.fetchOne();
    return Response.ok(word);
  }

  @Operation.post()
  Future<Response> addWord(@Bind.body(ignore: ['id']) Word newWord) async {
    final query = Query<Word>(context)..values = newWord;
    final insert = await query.insert();
    return Response.ok(insert);
  }

  @Operation.put('id')
  Future<Response> updateWord(@Bind.path('id') int id, @Bind.body(ignore: ['id']) Word updateWord) async {
    final query = Query<Word>(context)
      ..values = updateWord..where((x) => x.id).equalTo(id);
    final update = await query.updateOne();
    return Response.ok(update);
  }

  @Operation.delete('id')
  Future<Response> deleteWord(@Bind.path('id') int id) async {
    final query = Query<Word>(context)..where((x) => x.id).equalTo(id);
    final deleteWord = await query.delete();
    final message = {'message': 'delete $deleteWord success'};
    return Response.ok(message);
  }
}