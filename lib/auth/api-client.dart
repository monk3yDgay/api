import 'package:api/models/message.dart';
import 'package:api/models/post.dart';
import 'package:api/models/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part "api-client.g.dart";

// @RestApi(baseUrl: "http://10.0.2.2:8000/api/")
@RestApi(baseUrl: "https://bet2d.herokuapp.com/api/v1/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  @POST("/user")
  Future<Message> register(@Body() User user);

  @POST("auth/login")
  Future<Message> login(@Body() User user);
  @GET("/posts")
  Stream<List<Post>> getAllPosts(@Header('Authorization') String authApi);
}
