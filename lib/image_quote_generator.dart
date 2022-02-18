import 'package:image/image.dart';

List<String> formatQuoteLines(
  BitmapFont font,
  String quote,
  int contentWidth,
  int padding,
) {
  final words = quote.split(' ');
  final spaceCode = ' '.codeUnits[0];
  final spaceWidth = font.characters[spaceCode]!.xadvance;
  final lines = <String>[];
  var lineWidth = 0;
  var sb = StringBuffer();

  for (var jj = 0; jj < words.length; jj++) {
    final w = words[jj];
    final ww = getWordWidth(font, w);

    if (lineWidth + ww < (contentWidth - (padding * 2))) {
      sb.write('$w ');
      lineWidth += ww + spaceWidth;

      if (jj == words.length - 1) {
        lines.add(sb.toString());
      }
    } else {
      lines.add(sb.toString());
      sb = StringBuffer('$w ');
      lineWidth = ww;
    }
  }

  return lines;
}

int getWordWidth(BitmapFont font, String word) {
  final chars = word.codeUnits;
  var wLen = 0;

  for (var c in chars) {
    if (!font.characters.containsKey(c)) {
      continue;
    }
    final ch = font.characters[c]!;
    wLen += ch.xadvance;
  }

  return wLen;
}
