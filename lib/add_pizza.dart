import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_hut_admin/bloc/getandadd/bloc/bloc/pizzaadd_bloc.dart';
import 'package:pizza_hut_admin/bloc/getandadd/model/pizzamodel.dart';
import 'package:pizza_hut_admin/bloc/image_bloc/img_bloc_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddPizzaScreen extends StatefulWidget {
  const AddPizzaScreen({Key? key}) : super(key: key);

  @override
  State<AddPizzaScreen> createState() => _AddPizzaScreenState();
}

class _AddPizzaScreenState extends State<AddPizzaScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _category = 'Veg';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PizzaaddBloc>().add(GetPizzaEvent());
  }

  void _showAddPizzaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Pizza'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Card(
                            elevation: 10,
                            child: BlocBuilder<ImgBlocBloc, ImgBlocState>(
                              builder: (context, state) {
                                if (state.file == null || state.file!.isEmpty) {
                                  return Container(
                                    width: 300,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.image,
                                          size: 50, color: Colors.grey),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    width: 300,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: MemoryImage(state.file![0]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<ImgBlocBloc>(context)
                                  .add(gellaryPickerEvent());
                            },
                            child: Text('Pick Image'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _priceController,
                                decoration: InputDecoration(
                                  labelText: 'Price',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: _category,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _category = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Veg',
                                  'Non-Veg'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  labelText: 'Category',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            BlocBuilder<ImgBlocBloc, ImgBlocState>(
              builder: (contexts, state) {
                return TextButton(
                  child: Text('Add'),
                  onPressed: () async {
                    firebase_storage.Reference ref =
                        firebase_storage.FirebaseStorage.instance.ref(
                            '${DateTime.now().millisecondsSinceEpoch.toString()}');
                    firebase_storage.UploadTask uploadTask =
                        ref.putData(state.file![0]);
                    await uploadTask;
                    String downloadURL = await ref.getDownloadURL();
                    var pizza = Pizza(
                        pid: '',
                        name: _nameController.text,
                        cate: _category,
                        imageUrl: downloadURL.toString(),
                        description: _descriptionController.text,
                        price: _priceController.text);
                    BlocProvider.of<PizzaaddBloc>(context)
                        .add(PizzaAddedEvent(pizza: pizza, context: context));
                    BlocProvider.of<ImgBlocBloc>(context).add(SaveEvent());
                    _nameController.clear();
                    _descriptionController.clear();
                    _priceController.clear();
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _showAddPizzaDialog(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 70),
              IconButton(
                  onPressed: () {
                    context.read<PizzaaddBloc>().add(GetPizzaEvent());
                  },
                  icon: Icon(Icons.refresh))
            ],
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Check the screen width and adjust the crossAxisCount accordingly
                int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

                return BlocBuilder<PizzaaddBloc, PizzaaddState>(
                  builder: (context, state) {
                    if (state is PizzaaddInitial) {
                      return GridView.builder(
                        itemCount: 10, // Number of items
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount, // Number of columns
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.yellow, // Yellow color
                            margin: EdgeInsets.all(
                                10.0), // Margin around each container
                            child: Center(
                              child: Text(
                                'Item $index',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is PizzaGetSucces) {
                      return GridView.builder(
                        itemCount: state.pizzaList!.length, // Number of items
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount, // Number of columns
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            state.pizzaList![index].imageUrl),
                                        fit: BoxFit.cover)),
                                child: Text(index.toString()),
                              ),
                              Text("${state.pizzaList![index].name}"),
                              Text("${state.pizzaList![index].price}"),
                            ],
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text("Excpetion"),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
