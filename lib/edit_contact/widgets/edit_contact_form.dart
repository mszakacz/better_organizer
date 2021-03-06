import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_organizer/edit_contact/edit_contact.dart';
import 'package:contacts_repository/contacts_repository.dart';

class EditContactForm extends StatelessWidget {
  const EditContactForm({Key? key, required this.contact}) : super(key: key);

  final Contact contact;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
      child: BlocListener<EditContactBloc, EditContactState>(
        listenWhen: (previous, current) => current.status != previous.status,
        listener: (context, state) => {
          if (state.status == EditContactStatus.success)
            {
              Navigator.pop(context),
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Contact has been updated successfully'),
                  ),
                ),
            }
          else if (state.status == EditContactStatus.failure)
            {
              Navigator.pop(context),
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Fail to updated the contact'),
                  ),
                ),
            }
        },
        child: BlocBuilder<EditContactBloc, EditContactState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Icon(Icons.person),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: contact.name,
                        onChanged: (value) =>
                            BlocProvider.of<EditContactBloc>(context)
                                .add(NameEditing(value)),
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: TextFormField(
                        initialValue: contact.lastname,
                        onChanged: (value) =>
                            BlocProvider.of<EditContactBloc>(context)
                                .add(LastnameEditing(value)),
                        decoration: const InputDecoration(
                          labelText: 'Lastname',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Icon(Icons.phone),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: contact.mobile,
                        onChanged: (value) =>
                            BlocProvider.of<EditContactBloc>(context)
                                .add(MobileEditing(value)),
                        decoration: const InputDecoration(
                          labelText: 'Mobile',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Icon(Icons.mail),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: contact.mail,
                        onChanged: (value) =>
                            BlocProvider.of<EditContactBloc>(context)
                                .add(MailEditing(value)),
                        decoration: const InputDecoration(
                          labelText: 'Mail',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Icon(Icons.location_pin),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: contact.address,
                        onChanged: (value) =>
                            BlocProvider.of<EditContactBloc>(context)
                                .add(AddressEditing(value)),
                        decoration: const InputDecoration(
                          labelText: 'Address',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                    child: const Text('Save changes'),
                    onPressed: () => {
                          BlocProvider.of<EditContactBloc>(context)
                              .add(const SaveChanges()),
                          Navigator.of(context).pop(),
                        }),
              ],
            );
          },
        ),
      ),
    );
  }
}
