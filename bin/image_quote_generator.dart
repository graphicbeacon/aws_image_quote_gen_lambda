import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';
import 'package:aws_lambda_dart_runtime/runtime/context.dart';
import 'package:image_quote_generator/image_quote_generator.dart';

void main(List<String> arguments) {
  // Handling an API Gateway request.
  Future<AwsApiGatewayResponse> helloApiGateway(
      Context context, AwsApiGatewayEvent event) async {
    //
    final response = {'message': 'hello ${context.requestId}'};

    // returns a response to the gateway
    return AwsApiGatewayResponse.fromJson(response);
  }

  // The Runtime is a singleton. You can define the handlers as you wish.
  Runtime()
    ..registerHandler<AwsApiGatewayEvent>('hello.apigateway', helloApiGateway)
    ..invoke();
}
