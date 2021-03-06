import 'package:rxdart/rxdart.dart';
import 'package:xICMP_Monitoring_tool/repository/HostModel.dart';
import 'package:xICMP_Monitoring_tool/repository/HostsRepo.dart';

class HostsDataBloc {
  final _repository = HostsRepo();
  final _hosts = BehaviorSubject<Future<List<HostModel>>>();

  HostsDataBloc() {
    updateHosts();
  }

  Stream<Future<List<HostModel>>> get hosts => _hosts.stream;

  void updateHosts() {
    _hosts.sink.add(_repository.hosts);
  }

  void addHost(String hostname) async {
    await _repository.addHost(hostname);
    updateHosts();
  }

  void deleteHost(String hostname) async {
    await _repository.deleteHost(hostname);
    updateHosts();
  }

  void startAll() => _repository.startAll();
  void stopAll() => _repository.stopAll();
  void deleteAll() async {
    await _repository.deleteAll();
    updateHosts();
  }
}
