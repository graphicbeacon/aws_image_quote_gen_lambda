import 'dart:convert';

import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';
import 'package:aws_lambda_dart_runtime/runtime/context.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart';
import 'package:image_quote_generator/image_quote_generator.dart';

void main() async {
  Future<String> generate(Context context, AwsApiGatewayEvent event) async {
    try {
      final quoteRes = await http.get(Uri.parse(
          'https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en'));
      final resText = quoteRes.body.replaceAll(r'\', '');
      final quote = json.decode(resText);
      print(quote);

      final font = arial_24;
      final lineHeight = arial_24.lineHeight + 10;
      final padding = 10;
      final lines =
          formatQuoteLines(font, quote['quoteText'].trim(), 300, padding);
      print(lines);

      var imgHeight = lineHeight * lines.length;

      if (quote['quoteAuthor']?.trim().isEmpty == false) {
        imgHeight = lineHeight * (lines.length + 1);
      }

      final image = Image(300, imgHeight);

      fill(image, getColor(43, 61, 69));

      // Write out quote lines
      for (var ii = 0; ii < lines.length; ii++) {
        drawString(
            image, font, padding, padding + (lineHeight * ii), lines[ii]);
      }

      if (quote['quoteAuthor']?.trim().isEmpty == false) {
        drawString(
          image,
          font,
          padding,
          padding + (lineHeight * lines.length),
          '-- ${quote["quoteAuthor"]}',
        );
      }

      final png = encodePng(image);

      return base64Encode(png);
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  // The Runtime is a singleton. You can define the handlers as you wish.
  Runtime()
    ..registerHandler<AwsApiGatewayEvent>('quote.generate', generate)
    ..invoke();
}
