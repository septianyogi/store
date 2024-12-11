import 'package:store/app/models/products.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {
  Future<Response> index() async {
    try {
      List<Map<String, dynamic>> product = await Products()
          .query()
          .select(['vend_id', 'prod_name', 'prod_price', 'prod_desc']).get();
      return Response.json(
          {'data': product, 'message': 'produk berhasil diambil'}, 200);
    } catch (e) {
      return Response.json({'message': 'Error: ${e.toString()}'});
    }
  }

  Future<Response> create(Request request) async {
    try {
      request.validate({
        'vend_id': 'required',
        'prod_name': 'required',
        'prod_price': 'required',
        'prod_desc': 'required'
      });

      final product = await Products().query().insert({
        'vend_id': request.input('vend_id'),
        'prod_name': request.input('prod_name'),
        'prod_price': request.input('prod_price'),
        'prod_desc': request.input('prod_desc')
      });
      return Response.json(
          {'data': product, 'message': 'produk berhasil ditambahkan'}, 201);
    } catch (e) {
      return Response.json({'message': 'Error: ${e.toString()}'});
    }
  }

  Future<Response> update(Request request, int id) async {
    try {
      request.validate({
        'vend_id': 'required',
        'prod_name': 'required',
        'prod_price': 'required',
        'prod_desc': 'required'
      });

      final product = await Products().query().where('id', '=', id).update({
        'vend_id': request.input('vend_id'),
        'prod_name': request.input('prod_name'),
        'prod_price': request.input('prod_price'),
        'prod_desc': request.input('prod_desc')
      });
      return Response.json(
          {'data': product, 'message': 'produk berhasil diubah'}, 200);
    } catch (e) {
      return Response.json({'message': 'Error: ${e.toString()}'});
    }
  }

  Future<Response> destroy(int id) async {
    try {
      final product = await Products().query().where('id', '=', id).delete();
      return Response.json(
          {'data': product, 'message': 'produk berhasil dihapus'}, 200);
    } catch (e) {
      return Response.json({'message': 'Error: ${e.toString()}'});
    }
  }
}

final ProductController productController = ProductController();
