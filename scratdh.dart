void main() {
  print('start');
  printFileContent();
  print('end');
}

printFileContent() async {
  Future fileContent = downLoadAFile();
  print(fileContent);
  print("after download");
}

Future<String> downLoadAFile() {
  Future<String> result = Future.delayed(Duration(seconds: 3), () {
    return "downloaded content";
  });
  return result;
}
