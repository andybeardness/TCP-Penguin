import 'package:flutter/material.dart';
import 'package:tcp_penguin/data/repository/host/host_entity.dart';

class HomeScreenViewSavedHostsEntity {
  final List<HostEntity> hosts;

  HomeScreenViewSavedHostsEntity({required this.hosts});
}

class HomeScreenViewSavedHosts extends StatelessWidget {
  final HomeScreenViewSavedHostsEntity entity;

  const HomeScreenViewSavedHosts({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saved Hosts:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ...entity.hosts.map((host) {
            return Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(host.host),
                    Text(host.openPorts.join(', ')),
                    Text(host.createdAt.toString()),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
