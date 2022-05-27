abstract class ProductsEvent {
  const ProductsEvent();
}

class ProductsFetchEvent extends ProductsEvent {

  String lang;

  ProductsFetchEvent(this.lang);

  String get language => lang;

}