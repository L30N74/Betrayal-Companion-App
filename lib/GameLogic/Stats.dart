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

    Reset();
  }

  void resetMight() { mightIndex = mightDefaultIndex; }
  void resetSpeed() { speedIndex = speedDefaultIndex; }
  void resetSanity() { sanityIndex = sanityDefaultIndex; }
  void resetKnowledge() { knowledgeIndex = knowledgeDefaultIndex; }

  void Reset(){
    resetSpeed();
    resetMight();
    resetSanity();
    resetKnowledge();
  }

  void DieFromStat(String stat) {
    switch(stat) {
      case "Might":
        mightIndex = 0;
        break;
      case "Speed":
        speedIndex = 0;
        break;
      case "Sanity":
        sanityIndex = 0;
        break;
      case "Knowledge":
        knowledgeIndex = 0;
        break;
    }
  }

  bool IsCurrentIndex(String stat, int index) {
    bool val = false;

    switch(stat) {
      case "Might":
        val = (mightIndex == index);
        break;
      case "Speed":
        val = (speedIndex == index);
        break;
      case "Sanity":
        val = (sanityIndex == index);
        break;
      case "Knowledge":
        val = (knowledgeIndex == index);
        break;
    }

    return val;
  }

  void SetStatIndex(String stat, int index) {
    switch(stat) {
      case "Might":
        mightIndex = index;
        break;
      case "Speed":
        speedIndex = index;
        break;
      case "Sanity":
        sanityIndex = index;
        break;
      case "Knowledge":
        knowledgeIndex = index;
        break;
    }
  }
}
