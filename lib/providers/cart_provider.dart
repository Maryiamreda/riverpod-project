import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_files/models/product.dart';
part 'cart_provider.g.dart';

// Notifier Providers
// use when you need to update the state & notify consumers
@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  //initial value
  Set<Product> build() {
    return const {};
  }

  // methods to update state
  void addProduct(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  void removeProduct(Product product) {
    if (state.contains(product)) {
      state = state.where((p) => p.id != product.id).toSet();
    }
  }
}

//dependent provider
@riverpod
int cartTotal(ref) {
  final cartProducts = ref.watch(cartNotifierProvider);
  int total = 0;
  for (Product product in cartProducts) {
    total += product.price;
  }
  return total;
}

//this to access the state
// final CartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(() {
//   return CartNotifier();
// });
