import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class CardDataService {
  constructor() { }
  finish: boolean = false;
  lock = false;
  flipTimeout = 700;
  flippedCards = [];
  matchedCards = [];
  possibleCardFaces = ["A", "B", "C", "D", "E", "F", "A", "B", "C", "D", "E", "F"];

  areMatching(flippedCards) {
    return (flippedCards[0].img === flippedCards[1].img);
  }

  checkFlippedCards() {
    if (this.flippedCards.length === 2) {
      this.lock = true;
      if (this.areMatching(this.flippedCards)) {
        this.matchedCards.push(this.flippedCards[0], this.flippedCards[1]);
        this.flippedCards = [];
        this.lock = false;
        this.checkFinish();
      } else {
        this.hideCards();
      }
    }
  }

  hideCards() {
    setTimeout(() => {
      this.flippedCards[0].isShowContent = false;
      this.flippedCards[1].isShowContent = false;
      this.flippedCards = [];
      this.lock = false;
    }, this.flipTimeout);
  }

  restart() {
    window.location.reload();
  }

  checkFinish() {
    if (this.matchedCards.length === 12) {
      setTimeout(() => {
        this.finish = true;
      }, this.flipTimeout);
    }
  }
}
