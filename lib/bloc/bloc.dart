import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class Bloc<E, D> {

  D data;

  final _stateController = StreamController<D>();

  StreamSink<D> get _inEvent =>
      _stateController.sink;

  Stream<D> get stateStream => _stateController.stream;

  final _eventController = StreamController<E>();

  @mustCallSuper
  Bloc() {
    _eventController.stream.listen((e) => mapEventToState(e));
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }

  void putEvent(E event) {
    _eventController.sink.add(event);
  }

  void mapEventToState(E event) async {
    try {
      data = await retrieveData(event);
      _inEvent.add(data);
    } catch (e) {

    }
  }

  Future<D> retrieveData(E event);
}