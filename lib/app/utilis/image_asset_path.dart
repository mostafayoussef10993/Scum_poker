class ImageAssets {
  ImageAssets._();

  static const String voteCup = 'assets/votes/cup.jpg';
  static const String voteZero = 'assets/votes/0.jpg';
  static const String voteOne = 'assets/votes/1.jpg';
  static const String voteTwo = 'assets/votes/2.jpg';
  static const String voteThree = 'assets/votes/3.jpg';
  static const String voteFive = 'assets/votes/5.jpg';
  static const String voteEight = 'assets/votes/8.jpg';
  static const String voteThirteen = 'assets/votes/13.jpg';
  static const String voteTwenty = 'assets/votes/20.jpg';
  static const String voteForty = 'assets/votes/40.jpg';
  static const String voteEighty = 'assets/votes/80.jpg';
  static const String lightBG = 'assets/backgrounds/lightbg.jpg';
  static const String darkBG = 'assets/backgrounds/darkbg.jpg';
  static const String submitButton = 'assets/buttons/submit.png';
  static const String avatar = 'assets/avatar.png';
  static const String poker = 'assets/poker.png';
  static const String pokerResult = 'assets/poker_result.jpg';
  static const String clearButton = 'assets/buttons/delete.png';
  static const String delvotesButton = 'assets/buttons/delete_votes.png';

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
    voteEighty,
    voteCup,
  ];

  // Corresponding vote values for each image
  static const List<int> voteValues = [0, 1, 2, 3, 5, 8, 13, 20, 40, 80, 666];
}
