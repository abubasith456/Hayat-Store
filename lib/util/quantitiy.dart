import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cart_counter/cart_counter_cubit.dart';

Widget quantitiySelector(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: BlocBuilder<CartCounterCubit, double>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _decrementButton(context),
            SizedBox(
              width: 5,
            ),
            Text(
              '${state}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              width: 5,
            ),
            _incrementButton(context),
            SizedBox(
              width: 2,
            ),
          ],
        );
      },
    ),
  );
}

Widget _incrementButton(BuildContext context) {
  return Container(
    width: 50,
    height: 50,
    child: FloatingActionButton(
      child: Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        context.read<CartCounterCubit>().increment();
      },
    ),
  );
}

Widget _decrementButton(BuildContext context) {
  return Container(
    width: 50,
    height: 50,
    child: FloatingActionButton(
        onPressed: () {
          context.read<CartCounterCubit>().decrement();
        },
        child: Icon(Icons.remove, color: Colors.black),
        backgroundColor: Colors.white),
  );
}
