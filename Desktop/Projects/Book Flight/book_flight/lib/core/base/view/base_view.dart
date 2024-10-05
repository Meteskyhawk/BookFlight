import 'package:flutter/material.dart';

class BaseView<T> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final T viewModel;
  final Function(T) onModelReady;

  const BaseView(
      {super.key,
      required this.builder,
      required this.viewModel,
      required this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T> extends State<BaseView<T>> {
  @override
  void initState() {
    widget.onModelReady(widget.viewModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.viewModel, null);
  }
}
