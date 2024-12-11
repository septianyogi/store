import 'package:vania/vania.dart';

class CreateVendors extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('vendors', () {
      id();
      string('vend_name', length: 50);
      text('vend_address');
      text('vend_kota');
      string('vend_state', length: 10);
      string('vend_zip', length: 10);
      char('vend_country');
      timeStamps();
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('vendors');
  }
}
