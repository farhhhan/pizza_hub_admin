import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_hut_admin/bloc/getandadd/bloc/bloc/pizzaadd_bloc.dart';
import 'package:pizza_hut_admin/bloc/image_bloc/img_bloc_bloc.dart';
import 'package:pizza_hut_admin/bloc/image_bloc/repos.dart';
import 'package:pizza_hut_admin/bloc/indexbloc/slidebar_bloc.dart';
import 'package:pizza_hut_admin/firebase_options.dart';
import 'package:pizza_hut_admin/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => SlidebarBloc(),),
      BlocProvider(create: (context) => ImgBlocBloc(ImagePickerServices()),),
       BlocProvider(create: (context) => PizzaaddBloc(),)
    ], child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AdminLoginScreen(),
    ));
  }
}

class AdminLoginScreen extends StatefulWidget {
  AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  late SharedPreferences pref;
  bool? isUser;
  bool isHidden = true;

  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  isLoggedIn() async {
    pref = await SharedPreferences.getInstance();
    isUser = pref.getBool("login") ?? true;
    if (isUser == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPageScreen()),
      );
      print("hellow");
    }
  }

  togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 2 / 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(77, 126, 152, 233),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50),
                margin: EdgeInsets.symmetric(horizontal: 200, vertical: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 18.0, right: 18),
                            child: Icon(Icons.mail),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 79, 107, 158),
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 191, 191, 191),
                          ),
                          hintText: "Email",
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Card(
                      elevation: 5,
                      child: TextFormField(
                        obscureText: isHidden,
                        cursorColor: Colors.black,
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.lock),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 79, 107, 158),
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 191, 191, 191),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: togglePassword,
                            child: Icon(isHidden
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 79, 79, 79),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        String email = emailController.text;
                        String password = passwordController.text;

                        if (email == "admin@gmail.com" &&
                            password == "123456") {
                          pref.setBool("login", false);
                          pref.setString("email", email);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPageScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 60,
                          width: 300,
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Image.network(
                'https://media-cdn.tripadvisor.com/media/photo-s/29/ac/6d/7e/trevi-pizza.jpg',
                fit: BoxFit.cover,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 1 / 3,
            )
          ],
        ),
      ),
    );
  }
}
