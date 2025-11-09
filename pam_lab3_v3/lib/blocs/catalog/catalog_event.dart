class CatalogEvent {
  final String type; // 'start' | 'toggleFavorite'
  final int? productId;
  const CatalogEvent._(this.type, {this.productId});
  const CatalogEvent.start() : this._('start');
  const CatalogEvent.toggleFavorite(int id) : this._('toggleFavorite', productId: id);
}
