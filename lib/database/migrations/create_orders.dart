import 'package:vania/vania.dart';

class CreateOrders extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('orders', () {
      id();
      bigInt('cust_id', unsigned: true);
      foreign('cust_id', 'customers', 'id', constrained: true);
      date('order_date');
      timeStamps();
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orders');
  }
}
