class DetailsEvent {
  final String type; // 'start' | 'color' | 'image' | 'size' | 'wishlist'
  final int? index;

  const DetailsEvent._(this.type, {this.index});

  const DetailsEvent.start() : this._('start');
  const DetailsEvent.selectColor(int i) : this._('color', index: i);
  const DetailsEvent.selectImage(int i) : this._('image', index: i);
  const DetailsEvent.selectSize(int i) : this._('size', index: i);
  const DetailsEvent.toggleWishlist() : this._('wishlist');
}
