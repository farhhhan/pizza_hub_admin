part of 'pizzaadd_bloc.dart';

sealed class PizzaaddEvent extends Equatable {
  const PizzaaddEvent();

  @override
  List<Object> get props => [];
}
class PizzaAddedEvent extends PizzaaddEvent{
  Pizza? pizza;
  BuildContext context;
  PizzaAddedEvent({required this.pizza,required this.context});
}
class GetPizzaEvent extends PizzaaddEvent{}