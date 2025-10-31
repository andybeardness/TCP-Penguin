import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc_effect.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc_event.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc_state.dart';

class SavedScansScreenBody extends StatelessWidget {
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  SavedScansScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SavedScansScreenBloc, SavedScansScreenBlocState>(
      listenWhen: (previous, current) => previous.effect != current.effect,
      listener: (context, state) {
        final effect = state.effect;
        if (effect == null) return;

        final bloc = context.read<SavedScansScreenBloc>();

        bloc.add(InternalSavedScansScreenBlocEventClearEffect());

        switch (effect) {
          case SavedScansScreenBlocEffectNavigateBack():
            context.pop();
            break;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Saved Scans'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<SavedScansScreenBloc>().add(
                SavedScansScreenBlocEventOnClickNavigateBack(),
              );
            },
          ),
        ),
        body:
            BlocSelector<
              SavedScansScreenBloc,
              SavedScansScreenBlocState,
              List<SavedScansScreenBlocStateSavedScanItem>
            >(
              selector: (state) => state.savedScans,
              builder: (context, savedScans) {
                return ListView.builder(
                  itemCount: savedScans.length,
                  itemBuilder: (context, index) {
                    final item = savedScans[index];
                    return ListTile(
                      leading: const Icon(Icons.circle_rounded),
                      title: Text(item.host),
                      subtitle: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Open Ports: ${item.openPorts.join(', ')}'),
                            Text('Date: ${_dateFormat.format(item.dateTime)}'),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () {
                          context.read<SavedScansScreenBloc>().add(
                            SavedScansScreenBlocEventOnClickDeleteScan(
                              id: item.id,
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
      ),
    );
  }
}
