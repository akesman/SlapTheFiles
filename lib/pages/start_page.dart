import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick/cubit/game_cubit/game_cubit.dart';
import 'package:kick/cubit/user_cubit/user_cubit.dart';
import 'package:kick/data/models/user.dart';
import 'package:kick/tools/tools.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    if (BlocProvider.of<UserCubit>(context).currentUser != null) {
      _textEditingController.text =
          BlocProvider.of<UserCubit>(context).currentUser?.name ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text("Slap the flies"),
      ),*/
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundStart.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            await BlocProvider.of<UserCubit>(context).reloadUsers();
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Рейтинг",
                    style: TextStyle(fontSize: 26),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.black26,
                        border: Border.all(
                          width: 3,
                          color: Colors.black45,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state is UserInitialState) {
                          } else if (state is UserLoadState) {
                            return _buildList(state.userList);
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: TextField(
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Введите имя игрока"),
                      controller: _textEditingController,
                    ),
                  ),
                  RawMaterialButton(
                      fillColor: Colors.green,
                      child: const Text("Start"),
                      onPressed: () {
                        if (_textEditingController.text.isEmpty) return;

                        User? user = User(name: _textEditingController.text);
                        if (BlocProvider.of<UserCubit>(context).currentUser !=
                            null) {
                          user = BlocProvider.of<UserCubit>(context)
                              .currentUser
                              ?.merge(
                                User(
                                  name: _textEditingController.text,
                                ),
                              );
                        }

                        BlocProvider.of<UserCubit>(context).setCurrentUser =
                            user;
                        BlocProvider.of<GameCubit>(context).startGame(user!);
                        _textEditingController.clear();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<User> list) {
    return Scrollbar(
      child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    "${list[index].name!} ${list[index].point.toString()}",
                    style: TextStyle(fontSize: 20),
                  ),
                  leading: Text(
                    "${index + 1}",
                    style: TextStyle(fontSize: 24, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    Tools.getLocalString(
                      list[index].created_at!.toLocal(),
                    ),
                  ),
                ),
                const Divider(height: 2, endIndent: 10, indent: 10),
              ],
            );
          },
          itemCount: list.length),
    );
  }
}
