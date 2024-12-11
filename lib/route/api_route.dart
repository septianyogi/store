import 'package:store/app/http/controllers/customer_controller.dart';
import 'package:store/app/http/controllers/order_controller.dart';
import 'package:store/app/http/controllers/product_controller.dart';
import 'package:store/app/http/controllers/vendor_controller.dart';
import 'package:vania/vania.dart';
import 'package:store/app/http/controllers/home_controller.dart';
import 'package:store/app/http/middleware/authenticate.dart';
import 'package:store/app/http/middleware/home_middleware.dart';
import 'package:store/app/http/middleware/error_response_middleware.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    final productController = ProductController();
    final vendorController = VendorController();

    Router.post("/product/create",
        (Request request) => productController.create(request));
    Router.get("/product/get", productController.index);
    Router.patch("/product/update/{id}",
        (Request request, int id) => productController.update(request, id));
    Router.delete(
        "/product/delete/{id}", (int id) => productController.destroy(id));

    Router.post("/vendor/create",
        (Request request) => vendorController.create(request));
    Router.get("/vendor/get", vendorController.index);
    Router.patch("/vendor/update/{id}",
        (Request request, int id) => vendorController.update(request, id));
    Router.delete(
        "/vendor/delete/{id}", (int id) => vendorController.destroy(id));

    Router.post('/customer/create', (Request request) {
      customerController.create(request);
    });
    Router.get('/customer/get', customerController.index);
    Router.patch('/customer/update', (Request request, int id) {
      customerController.update(request, id);
    });
    Router.delete('/customer/delete', (int id) {
      customerController.destroy(id);
    });

    Router.post('/order/create', (Request request) {
      orderController.create(request);
    });
    Router.get('/order/get', orderController.index);
    Router.patch('/order/update', (Request request, int id) {
      orderController.update(request, id);
    });
    Router.delete('/order/delete', (int id) {
      orderController.destroy(id);
    });

    Router.get("/home", homeController.index);

    Router.get("/hello-world", () {
      return Response.html('Hello World');
    }).middleware([HomeMiddleware()]);

    // Return error code 400
    Router.get('wrong-request',
            () => Response.json({'message': 'Hi wrong request'}))
        .middleware([ErrorResponseMiddleware()]);

    // Return Authenticated user data
    Router.get("/user", () {
      return Response.json(Auth().user());
    }).middleware([AuthenticateMiddleware()]);
  }
}
