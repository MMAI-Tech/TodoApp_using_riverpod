

import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_app/item.dart';



final itemProvider = StateNotifierProvider<ItemNotifier,List<Item>>((ref){
  return ItemNotifier() ;
});


class ItemNotifier extends StateNotifier<List<Item>>{
  ItemNotifier() : super([]);

  void add(String line){
    final item = Item(id: DateTime.now().toString(),text: line,ischeck: false);
    state.add(item);
    state= state.toList();
  }

  void toggle(int index){
    state[index].ischeck = !state[index].ischeck;
    state = state.toList();
  }
  
  void delete(String id){
    state.removeWhere((Item)=>Item.id == id);
    state = state.toList();
  }
}