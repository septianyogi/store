import 'package:store/app/models/customer.dart';
import 'package:vania/vania.dart';

class CustomerController extends Controller {
  Future<Response> index() async {
    final customer = await Customer().query().select([
      'cust_name',
      'cust_address',
      'cust_city',
      'cust_state',
      'cust_zip',
      'cust_country'
    ]).get();
    return Response.json(
        {'data': customer, 'message': 'customer berhasil diambil'}, 200);
  }

  Future<Response> create(Request request) async {
    request.validate({
      'cust_name': 'required',
      'cust_address': 'required',
      'cust_city': 'required',
      'cust_state': 'required',
      'cust_zip': 'required',
      'cust_country': 'required',
      'cust_telp': 'required'
    });

    await Customer().query().insert({
      'cust_name': request.input('cust_name'),
      'cust_address': request.input('cust_address'),
      'cust_city': request.input('cust_city'),
      'cust_state': request.input('cust_state'),
      'cust_zip': request.input('cust_zip'),
      'cust_country': request.input('cust_country'),
      'cust_telp': request.input('cust_telp')
    });

    return Response.json({'message': 'customer berhasil ditambahkan'}, 201);
  }

  Future<Response> update(Request request, int id) async {
    request.validate({
      'cust_name': 'required',
      'cust_address': 'required',
      'cust_city': 'required',
      'cust_state': 'required',
      'cust_zip': 'required',
      'cust_country': 'required'
    });

    final customer = await Customer().query().where('id', '=', id).update({
      'cust_name': request.input('cust_name'),
      'cust_address': request.input('cust_address'),
      'cust_city': request.input('cust_city'),
      'cust_state': request.input('cust_state'),
      'cust_zip': request.input('cust_zip'),
      'cust_country': request.input('cust_country')
    });

    return Response.json(
        {'data': customer, 'message': 'customer berhasil diubah'}, 200);
  }

  Future<Response> destroy(int id) async {
    final customer = await Customer().query().where('id', '=', id).delete();
    return Response.json(
        {'data': customer, 'message': 'customer berhasil dihapus'}, 200);
  }
}

final CustomerController customerController = CustomerController();
