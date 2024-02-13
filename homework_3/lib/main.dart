import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:homework_3/comment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CommentAdapter());
  await Hive.openBox<Comment>('comments');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homework3(),
    );
  }
}

class Homework3 extends StatefulWidget {
  const Homework3({super.key});

  @override
  State<Homework3> createState() => _Homework3State();
}

class _Homework3State extends State<Homework3> {
  var box = Hive.box<Comment>('comments');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Homework 3"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (builder) => const AddCommentView()),
        ),
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Comment>('comments').listenable(),
        builder: (context, Box<Comment> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text("Add comments :)"),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (BuildContext context, int index) {
              Comment comment = box.getAt(index)!;

              return ListComment(comment: comment);
            },
          );
        },
      ),
    );
  }
}

class ListComment extends StatefulWidget {
  const ListComment({super.key, required this.comment});

  final Comment comment;

  @override
  State<ListComment> createState() => _ListCommentState();
}

class _ListCommentState extends State<ListComment> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(widget.comment.comment),
      trailing: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox.fromSize(
            size: const Size.square(48),
            child: Image.network(
              widget.comment.imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}

class AddCommentView extends StatefulWidget {
  const AddCommentView({super.key});

  @override
  State<AddCommentView> createState() => _AddCommentViewState();
}

class _AddCommentViewState extends State<AddCommentView> {
  var box = Hive.box<Comment>("comments");
  var urls = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Monkey_drinking_coca-cola.jpg/640px-Monkey_drinking_coca-cola.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Man_of_the_woods.JPG/640px-Man_of_the_woods.JPG"
  ];

  late String selected;
  var count = 0;
  var controller = TextEditingController();

  saveComment() {
    var comment = Comment(comment: controller.text, imageUrl: selected);
    box.add(comment);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    selected = urls.first;
  }

  Future<void> pickMonkey() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Monkey or Ape"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  for (var url in urls)
                    GestureDetector(
                      child: Image.network(url),
                      onTap: () {
                        setState(() => selected = url);
                        Navigator.of(context).pop();
                      },
                    )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Add a new note"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter a comment",
            ),
          ),
          ElevatedButton(
            onPressed: pickMonkey,
            child: const Text("Select image"),
          ),
          ElevatedButton(
            onPressed: saveComment,
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
