import 'package:store/app/models/customer.dart';
import 'package:vania/vania.dart';

class CustomerController extends Controller {

     Future<Response> index() async {
      try {
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
      } catch (e) {
        return Response.json({'message': 'Error: ${e.toString()}'});
      }
     }

     Future<Response> create(Request request) async {
      try {
        request.validate({
          'cust_name': 'required',
          'cust_address': 'required',
          'cust_city': 'required',
          'cust_state': 'required',
          'cust_zip': 'required',
          'cust_country': 'required'
        });

        final customer = await Customer().query().insert({
          'cust_name': request.input('cust_name'),
          'cust_address': request.input('cust_address'),
          'cust_city': request.input('cust_city'),
          'cust_state': request.input('cust_state'),
          'cust_zip': request.input('cust_zip'),
          'cust_country': request.input('cust_country')
        });

        return Response.json({
          'data': customer,
          'message': 'customer berhasil ditambahkan'
        }, 201);
      } catch (e) {
        return Response.json({'message': 'Error: ${e.toString()}'});
      }
     }

     Future<Response> update(Request request,int id) async {
        try {
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

          return Response.json({
            'data': customer,
            'message': 'customer berhasil diubah'
          }, 200);
        } catch (e) {
          return Response.json({'message': 'Error: ${e.toString()}'});
        }
     }

     Future<Response> destroy(int id) async {
      try {
        final customer = await Customer().query().where('id', '=', id).delete();
        return Response.json({
          'data': customer,
          'message': 'customer berhasil dihapus'
        }, 200);
      } catch (e) {
        return Response.json({'message': 'Error: ${e.toString()}'});
      }
     }
}

final CustomerController customerController = CustomerController();

