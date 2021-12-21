import 'package:equatable/equatable.dart';

class PaginationPage extends Equatable {
  final String name;
  final int page;

  const PaginationPage(this.name, this.page);
  @override
  List<Object?> get props => [name, page];
}
