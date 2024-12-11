import 'dart:io';
import 'package:vania/vania.dart';
import 'create_users_table.dart';
import 'create_product_notes.dart';
import 'create_orderitems.dart';
import 'create_orders.dart';
import 'create_vendors.dart';
import 'create_products.dart';
import 'create_customer_table.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		 await CreateCustomerTable().up();
     await CreateVendors().up();
		 await CreateUserTable().up();
     await CreateOrders().up();
     await CreateProducts().up();
     await CreateOrderitems().up();
		 await CreateProductNotes().up();
	}

  dropTables() async {
		 await CreateCustomerTable().down();
		 await CreateUserTable().down();
     await CreateOrders().down();
     await CreateOrderitems().down();
     await CreateProducts().down();
		 await CreateProductNotes().down();
		 await CreateVendors().down();
	 }
}
