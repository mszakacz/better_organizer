import 'package:better_organizer/new_contact/new_contact.dart';
import 'package:flutter/material.dart';
import 'package:better_organizer/contact_list/contact_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contacts_repository/contacts_repository.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => const ContactListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactListBloc(
        contactsRepository: RepositoryProvider.of<ContactsRepository>(context),
      ),
      child: const ContactListView(),
    );
  }
}

class ContactListView extends StatefulWidget {
  const ContactListView({Key? key}) : super(key: key);

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
                controller: _textController,
                onChanged: (value) => BlocProvider.of<ContactListBloc>(context)
                    .add(SearchEvent(searchingWord: value)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => {
                      _textController.clear(),
                      BlocProvider.of<ContactListBloc>(context).add(
                        const SearchEvent(
                          searchingWord: '',
                        ),
                      ),
                    },
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  hintText: 'Search...',
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                )),
          ),
        ),
      ),
      body: const ContactListWidget(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final result =
                await Navigator.of(context).push(NewContactPage.route());

            if (result != null) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(result),
                  ),
                );
            }
          },
          backgroundColor: Colors.blue),
    );
  }
}
