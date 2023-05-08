import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:todo_mtest/componenet/animation_container.dart';
import 'package:todo_mtest/componenet/bottom_sheet.dart';
import 'package:todo_mtest/componenet/button.dart';
import 'package:todo_mtest/componenet/custom_theme.dart';
import 'package:todo_mtest/componenet/textformfield.dart';
import 'package:todo_mtest/provider/todo_provider.dart';
import 'package:todo_mtest/utils/apptheme.dart';
import 'package:todo_mtest/utils/colors.dart';
import 'package:todo_mtest/utils/dimens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    if (provider.user == null) {
      return Container(
        decoration: BoxDecoration(gradient: TodoTheme.primaryGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomTheme(
            child1: AnimationContainer(lottie: 'animation/mobilenumber.json'),
            child2: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter Email Address And Password',
                  style: TodoTheme.primaryHeaderStyle,
                ),
                SizedBox(
                  height: Dimens.padding_xxl,
                ),
                TodoTextFormField(
                  textEditingController: _emailController,
                  label: 'Email',
                ),
                SizedBox(
                  height: Dimens.padding_xl,
                ),
                TodoTextFormField(
                  textEditingController: _passwordController,
                  label: 'Password',
                ),
                SizedBox(
                  height: Dimens.padding_xxl,
                ),
                TodoButton(
                  label: 'Sign In',
                  gradient: true,
                  onPressed: () {
                    provider.signIn(
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
    return 
    
    Container(
      decoration: BoxDecoration(gradient: TodoTheme.primaryGradient),
      child: Scaffold(
        appBar:AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                     provider.signOut();
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: Center(
                  child: DigitalClock(
                    secondDigitTextStyle:
                        TextStyle(color: todoColors.brightColor, fontSize: 30),
                    amPmDigitTextStyle:
                        TextStyle(color: todoColors.brightColor, fontSize: 20),
                    hourMinuteDigitTextStyle:
                        TextStyle(color: todoColors.brightColor, fontSize: 80),
                    is24HourTimeFormat: false,
                  ),
                ),
              ),
              Expanded(
                child: WBottomSheet(
                    child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.todos.length,
                    itemBuilder: (context, index) {
                      final todo = provider.todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        leading: Checkbox(
                          fillColor: MaterialStateProperty.all(
                              todoColors.primaryColor),
                          value: todo.isDone,
                          onChanged: (_) {
                            provider.toggleDone(todo);
                          },
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            provider.remove(todo);
                          },
                        ),
                      );
                    },
                  ),
                )),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton.large(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Container(
                        decoration: TodoTheme.dialogDecoration,
                        padding:
                            const EdgeInsets.all(Dimens.borderRadius_small),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TodoTextFormField(
                                textEditingController: _textEditingController,
                                label: 'Add a Task',
                              ),
                              SizedBox(
                                height: Dimens.padding_xxl,
                              ),
                              TodoButton(
                                label: 'Add',
                                gradient: true,
                                onPressed: () {
                                  provider.add(_textEditingController.text);
                                  _textEditingController.clear();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            backgroundColor: todoColors.primaryColor,
          )),
    );
  
  }
}
