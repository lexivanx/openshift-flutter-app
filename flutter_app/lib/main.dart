import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  List<Map<String, dynamic>> _users = [];

  // Database connection configuration
  final PostgreSQLConnection _connection = PostgreSQLConnection(
    'your_postgres_host',
    5432,
    'your_database_name',
    username: 'your_username',
    password: 'your_password',
  );

  @override
  void initState() {
    super.initState();
    _connectToDatabase();
  }

  Future<void> _connectToDatabase() async {
    await _connection.open();

    final results = await _connection.query('SELECT * FROM users');
    setState(() {
      _users = results;
    });
  }

  Future<void> _addUser() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    await _connection.query(
      'INSERT INTO users (username, email) VALUES (@username, @email)',
      substitutionValues: {
        'username': username,
        'email': email,
      },
    );

    final results = await _connection.query('SELECT * FROM users');
    setState(() {
      _users = results;
    });

    // Clear input fields
    _usernameController.clear();
    _emailController.clear();
  }

  @override
  void dispose() {
    _connection.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App with PostgreSQL'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Users in Database:',
              style: TextStyle(fontSize: 18),
            ),
            for (var user in _users)
              Text(
                '${user['username']} - ${user['email']}',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),
            Text(
              'Add New User:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
