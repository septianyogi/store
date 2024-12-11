import 'package:store/app/models/vendors.dart';
import 'package:vania/vania.dart';

class VendorController extends Controller {
  Future<Response> index() async {
    try {
      List<Map<String, dynamic>> vendor = await Vendor().query().select([
        'vend_name',
        'vend_address',
        'vend_kota',
        'vend_state',
        'vend_zip',
        'vend_country'
      ]).get();
      return Response.json(
          {'data': vendor, 'message': 'vendor berhasil diambil'}, 200);
    } catch (e) {
      return Response.json({'message': 'Error: ${e.toString()}'});
    }
  }

  Future<Response> create(Request request) async {
    try {
      request.validate({
        'vend_name': 'required',
        'vend_address': 'required',
        'vend_kota': 'required',
        'vend_state': 'required',
        'vend_zip': 'required',
        'vend_country': 'required'
      });

      final vendor = await Vendor().query().insert({
        'vend_name': request.input('vend_name'),
        'vend_address': request.input('vend_address'),
        'vend_kota': request.input('vend_kota'),
        'vend_state': request.input('vend_state'),
        'vend_zip': request.input('vend_zip'),
        'vend_country': request.input('vend_country')
      });
      return Response.json(
          {'data': vendor, 'message': 'vendor berhasil ditambahkan'});
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
    try {
      request.validate({
        'vend_name': 'required',
        'vend_address': 'required',
        'vend_kota': 'required',
        'vend_state': 'required',
        'vend_zip': 'required',
        'vend_country': 'required'
      });

      final vendor = await Vendor().query().where('id', '=', id).update({
        'vend_name': request.input('vend_name'),
        'vend_address': request.input('vend_address'),
        'vend_kota': request.input('vend_kota'),
        'vend_state': request.input('vend_state'),
        'vend_zip': request.input('vend_zip'),
        'vend_country': request.input('vend_country')
      });

      return Response.json(
          {'data': vendor, 'message': 'vendor berhasil diubah'}, 200);
    } catch (e) {
      return Response.json({'message': 'Error: ${e.toString()}'});
    }
  }

  Future<Response> destroy(int id) async {
    try {
      final vendor = await Vendor().query().where('id', '=', id).delete();
      return Response.json(
          {'data': vendor, 'message': 'vendor berhasil dihapus'}, 200);
    } catch (e) {
      return Response.json({'message': 'Error: ${e.toString()}'});
    }
  }
}

final VendorController vendorController = VendorController();
