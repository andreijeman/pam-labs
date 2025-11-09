import '../../models/details_page_data.dart';

class DetailsState {
  final String status; // 'initial' | 'loading' | 'success' | 'failure'
  final DetailsPageData? data;
  final int colorIndex;
  final int imageIndex;
  final int sizeIndex;
  final bool wishlisted;
  final String? error;

  const DetailsState({
    this.status = 'initial',
    this.data,
    this.colorIndex = 0,
    this.imageIndex = 0,
    this.sizeIndex = 0,
    this.wishlisted = false,
    this.error,
  });

  DetailsState copyWith({
    String? status,
    DetailsPageData? data,
    int? colorIndex,
    int? imageIndex,
    int? sizeIndex,
    bool? wishlisted,
    String? error,
  }) => DetailsState(
    status: status ?? this.status,
    data: data ?? this.data,
    colorIndex: colorIndex ?? this.colorIndex,
    imageIndex: imageIndex ?? this.imageIndex,
    sizeIndex: sizeIndex ?? this.sizeIndex,
    wishlisted: wishlisted ?? this.wishlisted,
    error: error ?? this.error,
  );
}
