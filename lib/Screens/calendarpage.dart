import 'package:UpTask/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:UpTask/Screens/taskpage.dart';
import 'package:UpTask/models/notes.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime selectedDate = DateTime.now();
  List<Todo> upTask = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todos = ref.watch(todoProvider);
    final upTask = ref.watch(todoProvider.notifier).listWiseDate(selectedDate);

    final completeCount = todos
        .where((todo) =>
            ref
                .read(todoProvider.notifier)
                .isSameDate(todo.dueDate, selectedDate) &&
            todo.isCompleted)
        .length;

    final pendingCount = todos
        .where((todo) =>
            ref
                .read(todoProvider.notifier)
                .isSameDate(todo.dueDate, selectedDate) &&
            !todo.isCompleted)
        .length;

    final total = completeCount + pendingCount;

    final progress = total == 0 ? 0.0 : completeCount / total;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [

          // Date Picker Card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: DatePicker(
                theme: DatePickerPlusTheme(
                  headerTheme: HeaderTheme(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                minDate: DateTime(2020),
                maxDate: DateTime(2035),

                onDateSelected: (date){
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            ),
          ),


          const SizedBox(height:25),


          sectionTitle("Selected Date"),


          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                Colors.blue.withOpacity(.15),
                child: const Icon(
                  Icons.calendar_month,
                  color: Colors.blue,
                ),
              ),

              title: Text(
                DateFormat("EEEE, dd MMM yyyy")
                    .format(selectedDate),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),



          const SizedBox(height:25),



          sectionTitle("Today's Progress"),


          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),

            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      Text(
                        "$completeCount Completed",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),


                      Text(
                        "$pendingCount Pending",
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      )

                    ],
                  ),


                  const SizedBox(height:15),


                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(20),

                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: progress,
                      backgroundColor:
                      Colors.grey.shade300,

                      color: Colors.green,
                    ),
                  ),

                ],
              ),
            ),
          ),



          const SizedBox(height:25),


          sectionTitle("Tasks"),



          ListView.builder(
            shrinkWrap:true,
            physics:
            const NeverScrollableScrollPhysics(),

            itemCount: upTask.length,


            itemBuilder:(context,index){

              final todo = upTask[index];


              final priorityColor =
              todo.priority=="Low"
                  ? Colors.green
                  : todo.priority=="Medium"
                  ? Colors.orange
                  : Colors.red;


              return Card(

                margin:
                const EdgeInsets.only(bottom:14),

                elevation:3,

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20),
                ),


                child: Padding(

                  padding:
                  const EdgeInsets.all(14),


                  child: Row(

                    children:[


                      Container(

                        height:55,
                        width:55,


                        decoration:
                        BoxDecoration(

                          color:
                          Color(todo
                              .catergoryIcon!
                              .color),

                          borderRadius:
                          BorderRadius.circular(16),
                        ),


                        child: Icon(
                          Constant.icons[
                          todo.catergoryIcon!.icon
                          ],

                          color:Colors.white,
                        ),

                      ),



                      const SizedBox(width:15),



                      Expanded(

                        child:Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,


                          children:[


                            Text(
                              todo.title,

                              style:
                              const TextStyle(

                                fontSize:17,

                                fontWeight:
                                FontWeight.bold,

                              ),
                            ),



                            const SizedBox(height:5),



                            Row(

                              children:[

                                const Icon(
                                  Icons.access_time,
                                  size:15,
                                  color:Colors.grey,
                                ),


                                const SizedBox(width:5),


                                Text(
                                  "${todo.hours}:${todo.minutues}",
                                  style:
                                  const TextStyle(
                                    color:Colors.grey,
                                  ),
                                ),



                                const SizedBox(width:12),



                                Container(

                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal:10,
                                    vertical:4,
                                  ),


                                  decoration:
                                  BoxDecoration(

                                    color:
                                    priorityColor
                                        .withOpacity(.15),

                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),


                                  child:Text(

                                    todo.priority ??
                                        "Normal",

                                    style:
                                    TextStyle(
                                      color:
                                      priorityColor,

                                      fontSize:12,

                                      fontWeight:
                                      FontWeight.bold,
                                    ),

                                  ),

                                )

                              ],

                            )

                          ],
                        ),
                      ),



                      Container(

                        padding:
                        const EdgeInsets.symmetric(
                          horizontal:10,
                          vertical:5,
                        ),


                        decoration:
                        BoxDecoration(

                          color:
                          todo.isCompleted
                              ? Colors.green.withOpacity(.15)
                              : Colors.orange.withOpacity(.15),

                          borderRadius:
                          BorderRadius.circular(20),

                        ),


                        child:Text(

                          todo.isCompleted
                              ?"Done"
                              :"Open",

                          style:
                          TextStyle(

                            color:
                            todo.isCompleted
                                ?Colors.green
                                :Colors.orange,

                            fontWeight:
                            FontWeight.bold,

                          ),

                        ),

                      )

                    ],

                  ),
                ),

              );

            },

          )

        ],
      ),
    );
  }
  Widget sectionTitle(String title){
    return Padding(
      padding: const EdgeInsets.only(bottom:10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize:18,
          fontWeight:FontWeight.bold,
        ),
      ),
    );
  }
}
