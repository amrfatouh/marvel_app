import 'package:equatable/equatable.dart';

class PaginationOffset extends Equatable {
  final String name;
  final int index;

  const PaginationOffset(this.name, this.index);
  @override
  List<Object?> get props => [name, index];
}
