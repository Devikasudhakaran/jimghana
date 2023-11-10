

import '../../constants/service_constants.dart';
import '../../constants/service_names.dart';
import '../../model_class/add_vehicle_response.dart';
import '../../utils/print_statements.dart';
import '../provider/add_api_provider.dart';

class JavaServices {
  final JavaApiProvider javaProvider = JavaApiProvider();

  Future<VehicleDetails> getVehicleDetails(String vehicle_no,
      String unique_id, String in_time, int driver_user_id) async {
    String serviceName = ServiceNames.addVehicleData;
    Map input = {
      ServiceConstants.Vehicle_no: vehicle_no,
      ServiceConstants.Unique_id: unique_id,
      ServiceConstants.In_time: in_time,
      ServiceConstants.Driver_user_id: driver_user_id,
    };
    printInDebug(input);
    final response = await javaProvider.getData(
        serviceName, input, ServiceNames.customerServiceController);
    printInDebug(response);
    return VehicleDetails.fromJson(response ?? {});
  }
}