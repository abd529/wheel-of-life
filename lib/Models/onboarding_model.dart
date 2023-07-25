class OnbordingContent {
  String image;
  String title;
  String discription;

  OnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<OnbordingContent> contents = [
  OnbordingContent(
      image: 'assets/onboard1.jpg',
      title: 'Welcome to True North',
      discription:
          "Begin your journey of self-discovery and personal growth with True North. Answer thought-provoking questions to unlock valuable insights and find your direction towards a more meaningful life."),
  OnbordingContent(
      image: 'assets/onboard2.jpg',
      title: 'Assess Your Life Holistically',
      discription:
          "Assess your life comprehensively with True North. Reflect on emotions, relationships, career, and personal development to gain clarity and balance in your life."),
  OnbordingContent(
      image: 'assets/onboard3.jpg',
      title: 'Cultivate Positive Change',
      discription:
          "Empower yourself with True North. Set realistic goals, build positive habits, and track your progress with tailored recommendations and abundant resources for a happier, fulfilled life."),
];