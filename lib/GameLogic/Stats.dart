import "dart:core";

class Stats {
  List<int> speed;
  int speedIndex;
  int speedDefaultIndex;
  List<int> might;
  int mightIndex;
  int mightDefaultIndex;
  List<int> sanity;
  int sanityIndex;
  int sanityDefaultIndex;
  List<int> knowledge;
  int knowledgeIndex;
  int knowledgeDefaultIndex;

  Stats(List<int> _speed, int _speedStartIndex, List<int> _might, int _mightStartIndex, List<int> _sanity, int _sanityStartIndex, List<int> _knowledge, int _knowledgeStartIndex) {
    this.speed = _speed;
    this.speedDefaultIndex = _speedStartIndex;
    this.might = _might;
    this.mightDefaultIndex = _mightStartIndex;
    this.sanity = _sanity;
    this.sanityDefaultIndex = _sanityStartIndex;
    this.knowledge = _knowledge;
    this.knowledgeDefaultIndex = _knowledgeStartIndex;
  }

  void increaseSpeed(){ speedIndex++; }
  void decreaseSpeed(){ speedIndex--; }
  int getSpeed() { return knowledge[speedIndex]; }
  void resetSpeed() { knowledgeIndex = knowledgeDefaultIndex; }

  void increaseMight(){ mightIndex++; }
  void decreaseMight(){ mightIndex--; }
  int getMight() { return knowledge[mightIndex]; }
  void resetMight() { knowledgeIndex = knowledgeDefaultIndex; }

  void increaseSanity(){ sanityIndex++; }
  void decreaseSanity(){ sanityIndex--; }
  int getSanity() { return knowledge[sanityIndex]; }
  void resetSanity() { knowledgeIndex = knowledgeDefaultIndex; }

  void increaseKnowledge(){ knowledgeIndex++; }
  void decreaseKnowledge(){ knowledgeIndex--; }
  int getKnowledge() { return knowledge[knowledgeIndex]; }
  void resetKnowledge() { knowledgeIndex = knowledgeDefaultIndex; }

  void resetAll(){
    resetSpeed();
    resetMight();
    resetSanity();
    resetKnowledge();
  }
}
