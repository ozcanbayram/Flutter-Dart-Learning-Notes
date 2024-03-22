import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';

class MyServiceView extends StatefulWidget {
  const MyServiceView({super.key});

  @override
  State<MyServiceView> createState() => _MyServiceViewState();
}

class _MyServiceViewState extends State<MyServiceView> {
  List<ServiceModel>? _items;
  String? name;
  bool _isLoading = false;

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchPostItems() async {
    _changeLoading();
    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;
      print('201 SUCCESSFULL');
      if (_datas is List) {
        setState(() {
          _items = _datas.map((e) => ServiceModel.fromJson(e)).toList();
          print('Data is a List (Succesfull)');
        });
      } else {
        print('Data is Not a List');
      }
    }
    _changeLoading();
  }

  @override
  void initState() {
    super.initState();
    fetchPostItems();
    name = 'Service Example';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _isLoading ? CircularProgressIndicator.adaptive() : SizedBox.shrink()
        ],
        title: Text(name ?? ''),
        backgroundColor: const Color.fromARGB(255, 64, 243, 70),
      ),
      body: ListView.builder(
        itemCount: _items?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_items?[index].name ?? ''),
          );
        },
      ),
    );
  }
}
