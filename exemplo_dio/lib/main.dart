import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
  var _nome = "Nome do Usuário";
  var _email = "Email do Usuário";
  ImageProvider _avatar = NetworkImage("https://via.placeholder.com/100");
  var _count = 1;
  TextEditingController _job = TextEditingController();
  Dio _dio;
  var _result = "";

  @override
  void initState() {
    super.initState();

    BaseOptions options = new BaseOptions(
      baseUrl: "https://reqres.in/api",
      connectTimeout: 5000,
    );

    _dio = new Dio(options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exemplo Dio"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  backgroundImage: _avatar,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _nome,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                _email,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 150,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: 'Digite a profissão',
                      ),
                  controller: _job,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.orange,
                    child: Text("Obter Perfil!"),
                    onPressed: () {
                      getProfile();
                    },
                  ),
                  MaterialButton(
                    color: Colors.orange,
                    child: Text("Enviar!"),
                    onPressed: () {
                      submitUser();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Resposta: $_result",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red
              ),)
            ],
          ),
        ),
      ),
    );
  }

  void getProfile() async {
    Response response = await _dio.get("/users/$_count");
    var profile = response.data["data"];
    setState(() {
      _nome = profile['first_name'] + " " + profile['last_name'];
      _email = profile['email'];
      _avatar = NetworkImage(profile['avatar']);
    });
  }

  void submitUser() async {
    Response response =
        await _dio.post("/users", data: {"name": _nome, "job": _job.text});
    print(response.data.toString());
    setState(() {
      _nome = "Nome do Usuário";
      _email = "Email do Usuário";
      _avatar = NetworkImage("https://via.placeholder.com/100");
      _job.text = "";
      _result = response.data.toString();
      _count++;
    });
  }
}
