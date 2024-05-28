import 'package:flutter/material.dart';
import 'package:orm/orm.dart';

import '_generated_prisma_client/model.dart';
import '_generated_prisma_client/prisma.dart';
import 'prisma.dart';

Future<void> main() async {
  await initPrismaClient();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter with ORM',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<User> users = [];
  SortOrder sort = SortOrder.desc;

  @override
  initState() {
    super.initState();
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users (${users.length})'), actions: [
        IconButton(
          tooltip: 'Switch sorting',
          onPressed: onTaggleSorting,
          icon: Icon(switch (sort) {
            SortOrder.asc => Icons.trending_up,
            SortOrder.desc => Icons.trending_down,
          }),
        ),
      ]),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverList.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users.elementAt(index);
                  return ListTile(
                    title: Text('User ID: ${user.id}'),
                    subtitle: Text('Username: ${user.name}'),
                  );
                },
              ),
              if (users.isEmpty)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Text('Users is empty, please create it.'),
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreate,
        child: const Icon(Icons.person_add),
      ),
    );
  }

  Future<void> onRefresh() {
    return prisma.user
        .findMany(
      orderBy: PrismaUnion.$2(UserOrderByWithRelationInput(id: sort)),
    )
        .then((users) {
      setState(() {
        this.users.clear();
        this.users.addAll(users);
      });
    });
  }

  void onCreate() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: false,
      enableDrag: true,
      showDragHandle: true,
      builder: (context) {
        final controller = TextEditingController();

        return BottomSheet(
          onClosing: controller.clear,
          builder: (BuildContext context) {
            return Column(
              children: [
                Text('Create User',
                    style: Theme.of(context).textTheme.titleLarge),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(label: Text('Name')),
                  ),
                ),
                FilledButton(
                  child: const Text('Create'),
                  onPressed: () => create(controller.text),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void create(String name) {
    prisma.user
        .create(data: PrismaUnion.$2(UserUncheckedCreateInput(name: name)))
        .then((user) {
      setState(() {
        if (sort == SortOrder.asc) {
          users.add(user);
        } else {
          users.insert(0, user);
        }
      });
      Navigator.of(context).pop();
    });
  }

  void onTaggleSorting() {
    sort = switch (sort) {
      SortOrder.asc => SortOrder.desc,
      SortOrder.desc => SortOrder.asc,
    };
    onRefresh();
  }
}
