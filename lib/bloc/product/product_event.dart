abstract class ProductEvent {
  const ProductEvent();
}

class LoadProducts extends ProductEvent {}

class LoadProduct extends ProductEvent {
  final int id;

  LoadProduct(this.id);
}
