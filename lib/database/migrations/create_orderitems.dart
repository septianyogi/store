import 'package:vania/vania.dart';

class CreateOrderitems extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('orderitems', () {
      id();
      bigInt('order_id', unsigned: true);
      foreign('order_id', 'orders', 'id', constrained: true, onDelete: 'CASCADE');
      bigInt('prod_id', unsigned: true);
      foreign('prod_id', 'products', 'id', constrained: true, onDelete: 'CASCADE');
      integer('quantity');
      timeStamps();
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orderitems');
  }
}
