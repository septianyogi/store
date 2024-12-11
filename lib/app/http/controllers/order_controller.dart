import 'package:store/app/models/order.dart';
import 'package:store/app/models/orderitems.dart';
import 'package:vania/vania.dart';

class OrderController extends Controller {
  Future<Response> index() async {
    try {
      final order =
          await Order().query().select(['cust_id', 'order_date']).get();
      return Response.json(
          {'data': order, 'message': 'order berhasil diambil'}, 200);
    } catch (e) {
      return Response.json({'message': 'Error: ${e.toString()}'});
    }
  }

  Future<Response> create(Request request) async {
    try {
      request.validate({
        'cust_id': 'required',
        'order_date': 'required',
        'items': 'required|array',
        'items.*.prod_id': 'required',
        'items.*.quantity': 'required|integer|min:1'
      });

      final order = await Order().query().insert({
        'cust_id': request.input('cust_id'),
        'order_date': request.input('order_date')
      });

      final items = request.input('items');
      for (var item in items) {
        await OrderItems()
            .query()
            .insert({'prod_id': item['prod_id'], 'quantity': item['quantity']});
      }

      return Response.json(
          {'data': order, 'message': 'order berhasil ditambahkan'}, 201);
    } catch (e) {
      return Response.json({'message': 'Error: ${e.toString()}'});
    }
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
    return Response.json({});
  }

  Future<Response> destroy(int id) async {
    try {
      final order = await Order().query().where('id', '=', id).delete();
      return Response.json(
          {'data': order, 'message': 'order berhasil dihapus'}, 200);
    } catch (e) {
      return Response.json({'message': 'Error: ${e.toString()}'});
    }
  }
}

final OrderController orderController = OrderController();
