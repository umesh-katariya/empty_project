import 'package:empty_project/app/data/ws/url_utils.dart';
import 'http_client.dart';

class ApiRepository {

  static ApiRepository instance = ApiRepository();
  final HttpClient client = HttpClient.instance(UrlUtils.baseUrl);

  // Future<APIResponse<UserModel>> getUserProfile({required String uid}) async {
  //   try {
  //     HttpResponse response = await client.get(
  //       path: "${UrlUtils.profile}/$uid",
  //     );
  //     if (response.status) {
  //       try {
  //         APIResponse<UserModel> apiResponse = APIResponse.fromHttpResponse(
  //           response,
  //           fromJsonModel: (json) => UserModel.fromJson(json),
  //         );
  //         return apiResponse;
  //       } catch (e) {
  //         print('ResponseError :: $e');
  //       }
  //     } else {
  //       return APIResponse(
  //           success: false,
  //           data: response.data,
  //           message: "",
  //           statusCode: response.statusCode);
  //     }
  //   } on Exception catch (e) {
  //     if (e.toString().contains("Unauthorized")) {
  //       throw Exception("Unauthorized");
  //     }
  //   } catch (e) {
  //     // ignore: avoid_print
  //     AppLog.d(e);
  //     if (e.toString().contains("Unauthorized")) {
  //       throw Exception("Unauthorized");
  //     }
  //   }
  //   return APIResponse(
  //     success: false,
  //     data: null,
  //     message: "Something went wrong",
  //   );
  // }
  //
  // Future<APIResponse<List<UserProfiles>>> searchProfile(
  //     {required Map<String, dynamic> bodyData, bool showLoader = false}) async {
  //   try {
  //     if (showLoader) await AppUtility.showProgressDialog();
  //     HttpResponse response;
  //     response = await client.post(
  //       path: UrlUtils.searchProfile,
  //       data: bodyData,
  //     );
  //     APIResponse<List<UserProfiles>> apiResponse =
  //         APIResponse.fromHttpResponse(
  //       response,
  //       fromJsonModel: (json) =>
  //           (json as List).map((e) => UserProfiles.fromJson(e)).toList(),
  //     );
  //     if (showLoader) Get.back();
  //     return apiResponse;
  //   } catch (e) {
  //     if (showLoader) Get.back();
  //     AppLog.d(e);
  //   }
  //   return APIResponse(
  //     success: false,
  //     data: null,
  //     message: "Something went wrong",
  //   );
  // }

}
