import 'dart:math';

import 'package:flutter/material.dart';

import 'prisma_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo, With Data Proxy',
      home: Users(),
    );
  }
}

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  late PrismaClient prisma;
  final List<User> users = [];

  /// Create a Prisma client.
  @override
  void initState() {
    super.initState();
    prisma = createPrismaClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        // Add a button to fetch users.
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              // Fetch users.
              final users = await prisma.user.findMany(
                orderBy:
                    const FindManyUserOrderBy.withUserOrderByWithRelationInput(
                  UserOrderByWithRelationInput(
                    id: SortOrder.asc,
                  ),
                ),
              );
              // Update the state.
              setState(() {
                this.users.clear();
                this.users.addAll(users);
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.createdAt.toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Generate a random name.
          String name = '';
          for (var i = 0; i < 10; i++) {
            name += String.fromCharCode(65 + Random().nextInt(26));
          }

          // Create a new user.
          final user = await prisma.user.create(
            data: CreateOneUserData.withUserUncheckedCreateInput(
              UserUncheckedCreateInput(
                name: name,
              ),
            ),
          );
          // Update the state.
          setState(() {
            users.add(user);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
