import 'domain_state_exception.dart';

class InvalidValueObjectStateException extends DomainStateException {
  InvalidValueObjectStateException({required super.message, super.parameters});
}
