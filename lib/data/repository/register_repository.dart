
import '../services/register_service.dart';

class RegisterRepository {
  final RegisterService _service;

  RegisterRepository(this._service);

  Future<List<String>> getBranchNames( ) {
    return _service.fetchBranchNames( );
  }
  Future<List<String>> getTreatmentNames( ) {
    return _service.fetchTreatmentNames();
  }
}
