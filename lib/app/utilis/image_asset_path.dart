// This is a class for naming the image assets in the project.

class ImageAssets {
  ImageAssets._();

  static const String voteCup = 'assets/votes/cup.png';
  static const String voteZero = 'assets/votes/0.png';
  static const String voteOne = 'assets/votes/1.png';
  static const String voteTwo = 'assets/votes/2.png';
  static const String voteThree = 'assets/votes/3.png';
  static const String voteFive = 'assets/votes/5.png';
  static const String voteEight = 'assets/votes/8.png';
  static const String voteThirteen = 'assets/votes/13.png';
  static const String voteTwenty = 'assets/votes/20.png';
  static const String voteForty = 'assets/votes/40.png';
  static const String voteHundred = 'assets/votes/100.png';
  static const String submitButton = 'assets/buttons/submit.svg';
  static const String avatar = 'assets/avatar.svg';
  static const String poker = 'assets/poker.png';
  static const String clearButton = 'assets/buttons/delete.svg';
  static const String delvotesButton = 'assets/buttons/delete_votes.svg';
  // List of all vote image paths for easy access
  static const List<String> allVotes = [
    voteZero,
    voteOne,
    voteTwo,
    voteThree,
    voteFive,
    voteEight,
    voteThirteen,
    voteTwenty,
    voteForty,
    voteHundred,
    voteCup,
  ];

  // Corresponding vote values for each image
  static const List<int> voteValues = [0, 1, 2, 3, 5, 8, 13, 20, 40, 100, 666];
}
