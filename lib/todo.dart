import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/item_provider.dart';

class TodoApp extends ConsumerStatefulWidget {
  const TodoApp({super.key});

  @override
  ConsumerState<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends ConsumerState<TodoApp> {
  final data = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Center(
          child: Text(
            'Todo App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey[300],
        padding: EdgeInsets.all(sw * 0.03),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: sw * 0.76,
                  child: TextFormField(
                    controller: data,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Add a new todo...',
                      hintStyle: TextStyle(color: Colors.grey[900]),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (data.text.isNotEmpty) {
                      ref.read(itemProvider.notifier).add(data.text);
                      data.clear();
                    }
                  },
                  child: Container(
                    height: sh * 0.065,
                    width: sw * 0.16,
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(sw * 0.03),
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: sw * 0.1),
                  ),
                ),
              ],
            ),
            SizedBox(height: sh * 0.03),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'My Todos',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),

            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final item = ref.watch(itemProvider);
                  return item.isEmpty ? Center(
                          child: Text('No Data', style: TextStyle(fontSize: 50, color: Colors.grey[600],),),
                        )
                      : ListView.builder(
                          itemCount: item.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(0),
                              margin: EdgeInsets.only(top: sw * 0.03, right: sw * 0.01, left: sw * 0.01, bottom: sw * 0.01,),
                              height: sh * 0.08,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(sw * 0.03), color: Colors.white,),
                              child: Center(
                                child: ListTile(
                                  leading: Checkbox(value: item[index].ischeck, onChanged: (x) {
                                      ref.read(itemProvider.notifier).toggle(index);
                                    },
                                  ),
                                  title: Text(item[index].text, style: TextStyle(color: Colors.black, decoration: item[index].ischeck ? TextDecoration.lineThrough : TextDecoration.none, fontSize: 18,),
                                  ),
                                  trailing: IconButton(onPressed: () {
                                      ref.read(itemProvider.notifier).delete(item[index].id);
                                    },
                                    icon: Icon(Icons.delete_forever_outlined, color: Colors.redAccent, size: 30,),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
