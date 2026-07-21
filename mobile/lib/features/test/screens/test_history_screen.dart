import 'package:flutter/material.dart';

import '../models/test_history_model.dart';
import '../repositories/test_history_repository.dart';

class TestHistoryScreen extends StatefulWidget {
  const TestHistoryScreen({super.key});

  @override
  State<TestHistoryScreen> createState() =>
      _TestHistoryScreenState();
}

class _TestHistoryScreenState
    extends State<TestHistoryScreen> {

  final TestHistoryRepository repository =
      TestHistoryRepository();

  List<TestHistoryModel> history = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    history = await repository.getAll();

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> clearHistory() async {

    await repository.clear();

    await loadHistory();
  }

  Color scoreColor(int score) {

    if (score >= 90) {
      return Colors.green;
    }

    if (score >= 75) {
      return Colors.lightGreen;
    }

    if (score >= 60) {
      return Colors.orange;
    }

    if (score >= 40) {
      return Colors.deepOrange;
    }

    return Colors.red;
  }

  String performance(int score) {

    if (score >= 90) {
      return "Excellent";
    }

    if (score >= 75) {
      return "Very Good";
    }

    if (score >= 60) {
      return "Good";
    }

    if (score >= 40) {
      return "Average";
    }

    return "Needs Improvement";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF6F8FC),

      appBar: AppBar(

        title: const Text("Test History"),

        actions: [

          if(history.isNotEmpty)

          IconButton(

            onPressed: () async {

              final confirm = await showDialog<bool>(

                context: context,

                builder: (_) => AlertDialog(

                  title: const Text("Clear History"),

                  content: const Text(
                    "Delete all completed tests?",
                  ),

                  actions: [

                    TextButton(

                      onPressed: () {
                        Navigator.pop(context,false);
                      },

                      child: const Text("Cancel"),

                    ),

                    ElevatedButton(

                      onPressed: () {
                        Navigator.pop(context,true);
                      },

                      child: const Text("Delete"),

                    ),

                  ],

                ),

              );

              if(confirm==true){
                clearHistory();
              }

            },

            icon: const Icon(Icons.delete),

          ),

        ],

      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : history.isEmpty

              ? const Center(

                  child: Column(

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Icon(
                        Icons.quiz_outlined,
                        size: 90,
                        color: Colors.grey,
                      ),

                      SizedBox(height:20),

                      Text(

                        "No Tests Yet",

                        style: TextStyle(

                          fontSize:22,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                      SizedBox(height:10),

                      Text(

                        "Complete your first assessment to\nsee your history here.",

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Colors.grey,
                        ),

                      ),

                    ],

                  ),

                )

              : RefreshIndicator(

                  onRefresh: loadHistory,

                  child: ListView.builder(

                    padding:
                        const EdgeInsets.all(20),

                    itemCount: history.length,

                    itemBuilder: (context,index){

                      final item = history[index];

                      final color =
                          scoreColor(item.percentage);

                      return Card(

                        margin: const EdgeInsets.only(
                          bottom: 16,
                        ),

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                                  18),

                        ),

                        child: ListTile(

                          contentPadding:
                              const EdgeInsets.all(16),

                          leading: CircleAvatar(

                            radius: 28,

                            backgroundColor:
                                color.withOpacity(.15),

                            child: Icon(

                              Icons.quiz,

                              color: color,

                            ),

                          ),

                          title: Text(

                            item.category,

                            style: const TextStyle(

                              fontWeight:
                                  FontWeight.bold,

                            ),

                          ),

                          subtitle: Padding(

                            padding:
                                const EdgeInsets.only(
                                    top: 8),

                            child: Column(

                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Text(
                                    "Stage ${item.stage}"),

                                const SizedBox(
                                    height:4),

                                Text(
                                    "${item.correct}/${item.totalQuestions} Correct"),

                                const SizedBox(
                                    height:4),

                                Text(
                                  item.completedAt
                                      .toLocal()
                                      .toString()
                                      .substring(0,16),
                                ),

                              ],

                            ),

                          ),

                          trailing: Column(

                            mainAxisAlignment:
                                MainAxisAlignment.center,

                            children: [

                              Text(

                                "${item.percentage}%",

                                style: TextStyle(

                                  color: color,

                                  fontSize:22,

                                  fontWeight:
                                      FontWeight.bold,

                                ),

                              ),

                              const SizedBox(height:4),

                              Text(

                                performance(
                                    item.percentage),

                                style: const TextStyle(

                                  fontSize:11,

                                ),

                              ),

                            ],

                          ),

                        ),

                      );

                    },

                  ),

                ),

    );

  }

}