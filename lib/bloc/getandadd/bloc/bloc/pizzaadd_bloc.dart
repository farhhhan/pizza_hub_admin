import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizza_hut_admin/bloc/getandadd/model/pizzamodel.dart';
import 'package:pizza_hut_admin/bloc/getandadd/repo.dart';

part 'pizzaadd_event.dart';
part 'pizzaadd_state.dart';

class PizzaaddBloc extends Bloc<PizzaaddEvent, PizzaaddState> {
  PizzaaddBloc() : super(PizzaaddInitial()) {
    on<GetPizzaEvent>(_onPizzaGetSucces);
    on<PizzaAddedEvent>(_onpizzaadd);
  }

  FutureOr<void> _onPizzaGetSucces(
      GetPizzaEvent event, Emitter<PizzaaddState> emit) async {
    emit(PizzaaddInitial());
    List<Pizza> listPizza = await PizzaServiese().getPizza();
    print(listPizza.length);
    emit(PizzaGetSucces(pizzaList: listPizza));
  }

  FutureOr<void> _onpizzaadd(
      PizzaAddedEvent event, Emitter<PizzaaddState> emit) async {
    emit(PizzaaddInitial());
    PizzaServiese().addPizza(event.pizza!, event.context);
    List<Pizza> listPizza = await PizzaServiese().getPizza();
    emit(PizzaGetSucces(pizzaList: listPizza));
  }
}
