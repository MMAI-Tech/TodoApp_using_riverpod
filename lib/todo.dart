import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/item_provider.dart';
import 'package:todo_app/old_version.dart';
import 'package:todo_app/tile.dart';

class TodoApp extends ConsumerStatefulWidget {
  const TodoApp({super.key});

  @override
  ConsumerState<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends ConsumerState<TodoApp> {
  final data = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery
        .of(context)
        .size
        .height;
    double sw = MediaQuery
        .of(context)
        .size
        .width;

    void dialogBox() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: sh * 0.23,
              width: sw * 0.9,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Add New Todo',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: sh * 0.02),
                  Container(
                    width: sw * 0.76,
                    child: TextFormField(
                      controller: data,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Add a new todo...',
                        hintStyle: TextStyle(color: Colors.grey[900]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(sw * 0.04),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: sh * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: sh * 0.065,
                          width: sw * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(sw * 0.03),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                          width: sw * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.blue[700],
                            borderRadius: BorderRadius.circular(sw * 0.03),
                          ),
                          child: Center(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: sh * 0.4,

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/back.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                       radius: sw*0.15,
                        backgroundColor: Colors.white,
                        child: Image.asset("assets/profile.png",fit: BoxFit.cover,),
                      ),
                      SizedBox(height: sh*0.01,),
                      Text("Arslan",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),

                      Text("Stay productive!",style: TextStyle(color: Colors.white,fontSize: 20,),),
                      SizedBox(height: sh*0.02,)
                    ],
                  ),
              ),
            ),
            SizedBox(height: sh*0.015,),
            Container(
              padding: EdgeInsets.all(sw*0.03),
              child:Consumer(builder: (context,ref,child){
                num indi = ref.watch(indicator);
               return Column(
                  children: [
                    Tile(

                      icon: Icons.home,
                      backgroundColor:indi == 1? Colors.blue.withValues(alpha: 0.2):Colors.transparent,
                      iconColor:indi == 1? Colors.blue[800]:Colors.black,
                      textColor: indi == 1?Colors.blue[800]:Colors.black,
                      name: "Home",
                      press: (){
                        ref.read(indicator.notifier).state = 1;
                      },
                    ),
                    Tile(
                      icon: Icons.assignment,
                      backgroundColor:indi == 2? Colors.blue.withValues(alpha: 0.2):Colors.transparent,
                      iconColor:indi == 2? Colors.blue[800]:Colors.black,
                      textColor: indi == 2?Colors.blue[800]:Colors.black,
                      name: "Todo",
                      press: (){
                        ref.read(indicator.notifier).state = 2;
                      },
                    ), Tile(
                      icon: Icons.settings,
                      backgroundColor:indi == 3? Colors.blue.withValues(alpha: 0.2):Colors.transparent,
                      iconColor:indi == 3? Colors.blue[800]:Colors.black,
                      textColor: indi == 3?Colors.blue[800]:Colors.black,
                      name: "Settings",
                      press: (){
                        ref.read(indicator.notifier).state = 3;
                      },
                    ), Tile(
                      icon: Icons.person_pin_outlined,
                      backgroundColor:indi == 4? Colors.blue.withValues(alpha: 0.2):Colors.transparent,
                      iconColor:indi == 4? Colors.blue[800]:Colors.black,
                      textColor: indi == 4?Colors.blue[800]:Colors.black,
                      name: "About Us",
                      press: (){
                        ref.read(indicator.notifier).state = 4;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: sh*0.015,bottom: sh*0.015),
                      width: sw*0.6,
                      height: sh*0.002,
                      color: Colors.grey[500],
                    ),
                    Tile(
                      iconColor: Colors.red,
                      textColor: Colors.red,
                      icon: Icons.login_outlined,
                      name: "Logout",
                    ),
                  ],
                );
              })

            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        onPressed: () {
          dialogBox();
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue[700],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Todo App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => OldVersion()));
              },
              icon: Icon(Icons.history, color: Colors.white, size: 25),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/home.png',
            height: sh * 0.25,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.grey[300],
              padding: EdgeInsets.all(sw * 0.03),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Container(
                  //       width: sw * 0.76,
                  //       child: TextFormField(
                  //         controller: data,
                  //         decoration: InputDecoration(
                  //           filled: true,
                  //           fillColor: Colors.white,
                  //           hintText: 'Add a new todo...',
                  //           hintStyle: TextStyle(color: Colors.grey[900]),
                  //           border: OutlineInputBorder(),
                  //         ),
                  //       ),
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         if (data.text.isNotEmpty) {
                  //           ref.read(itemProvider.notifier).add(data.text);
                  //           data.clear();
                  //         }
                  //       },
                  //       child: Container(
                  //         height: sh * 0.065,
                  //         width: sw * 0.16,
                  //         decoration: BoxDecoration(
                  //           color: Colors.blue[700],
                  //           borderRadius: BorderRadius.circular(sw * 0.03),
                  //         ),
                  //         child: Icon(Icons.add, color: Colors.white, size: sw * 0.1),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                        return item.isEmpty
                            ? Center(
                          child: Text(
                            'No Data',
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.grey[600],
                            ),
                          ),
                        )
                            : ListView.builder(
                          itemCount: item.length,
                          itemBuilder: (context, index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: StretchMotion(),
                                extentRatio: 0.25,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: sw * 0.02,
                                        top: sw * 0.03,
                                      ),
                                      height: sh * 0.08,

                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(
                                          sw * 0.04,
                                        ),
                                        color: Colors.red,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          ref
                                              .read(itemProvider.notifier)
                                              .delete(item[index].id);
                                        },
                                        icon: Icon(
                                          Icons.delete_forever_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.all(0),
                                margin: EdgeInsets.only(
                                  top: sw * 0.03,
                                  right: sw * 0.01,
                                  left: sw * 0.01,
                                  bottom: sw * 0.01,
                                ),
                                height: sh * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    sw * 0.03,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: ListTile(
                                    leading: Checkbox(
                                      value: item[index].ischeck,
                                      onChanged: (x) {
                                        ref
                                            .read(itemProvider.notifier)
                                            .toggle(index);
                                      },
                                    ),
                                    title: Text(
                                      item[index].text,
                                      style: TextStyle(
                                        color: Colors.black,
                                        decoration: item[index].ischeck
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        fontSize: 20,
                                      ),
                                    ),
                                    // trailing: IconButton(
                                    //   onPressed: () {
                                    //     ref
                                    //         .read(itemProvider.notifier)
                                    //         .delete(item[index].id);
                                    //   },
                                    //   icon: Icon(
                                    //     Icons.delete_forever_outlined,
                                    //     color: Colors.redAccent,
                                    //     size: 30,
                                    //   ),
                                    // ),
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
          ),
        ],
      ),
    );
  }
}
