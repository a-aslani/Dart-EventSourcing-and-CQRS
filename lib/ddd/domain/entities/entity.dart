import '../../equatable.dart';
import 'auditable_entity.dart';

abstract class Entity<T> extends AuditableEntity with EquatableMixin {
  T id;

  // BusinessId businessId = BusinessId.create(value: Guid());

  Entity({required this.id});

  @override
  List<Object> get props => [id.toString()];
}
