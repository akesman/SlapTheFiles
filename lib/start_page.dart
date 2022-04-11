import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick/cubit/user_cubit.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slap the flies"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<UserCubit>(context).reloadUsers();
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Рейтинг"),
                Expanded(
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is UserInitialState) {
                        BlocProvider.of<UserCubit>(context).reloadUsers();
                      } else if (state is UserLoadState) {
                        return _buildList(state.userList);
                      }
                      return Container();
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: TextField(
                    controller: _textEditingController,
                  ),
                ),
                RawMaterialButton(
                    fillColor: Colors.green,
                    child: const Text("Start"),
                    onPressed: () {
                      if (_textEditingController.text.isEmpty) return;
                      BlocProvider.of<UserCubit>(context).addUser(
                        User(
                          name: _textEditingController.text,
                          point: 10,
                        ),
                      );
                      _textEditingController.clear();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<User> list) {
    return ListView.builder(
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(list[index].point.toString()),
            leading: Text(list[index].name),
            subtitle: Text(
              Tools.getLocalString(
                list[index].created_at!.toLocal(),
              ),
            ),
          );
        },
        itemCount: list.length);
  }
}
