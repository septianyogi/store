import 'package:store/app/models/productnotes.dart';
import 'package:vania/vania.dart';

class ProductNotesController extends Controller {
  Future<Response> index() async {
    List<Map<String, dynamic>> productNotes = await ProductNotes()
        .query()
        .select(['prod_id', 'note_date', 'note_text']).get();
    return Response.json(
        {'data': productNotes, 'message': 'productNotes berhasil diambil'},
        200);
  }

  Future<Response> create(Request request) async {
    request.validate({
      'prod_id': 'required',
      'note_date': 'required',
      'note_text': 'required'
    });

    final productNotes = await ProductNotes().query().insert({
      'prod_id': request.input('prod_id'),
      'note_date': request.input('note_date'),
      'note_text': request.input('note_text')
    });
    return Response.json(
        {'data': productNotes, 'message': 'productNotes berhasil ditambahkan'});
  }

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    request.validate({
      'prod_id': 'required',
      'note_date': 'required',
      'note_text': 'required'
    });

    final productNotes =
        await ProductNotes().query().where('id', '=', id).update({
      'prod_id': request.input('prod_id'),
      'note_date': request.input('note_date'),
      'note_text': request.input('note_text')
    });

    return Response.json(
        {'data': productNotes, 'message': 'productNotes berhasil diubah'}, 200);
  }

  Future<Response> destroy(int id) async {
    final productNotes =
        await ProductNotes().query().where('id', '=', id).delete();
    return Response.json(
        {'data': productNotes, 'message': 'productNotes berhasil dihapus'},
        200);
  }
}

final ProductNotesController productNotesController = ProductNotesController();
