import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { CardDataService } from 'src/app/service/card-data/card-data.service';

@Component({
  selector: 'app-rolling-card',
  templateUrl: './rolling-card.component.html',
  styleUrls: ['./rolling-card.component.scss'],
})
export class RollingCardComponent implements OnInit {
  // @Input() isShowContent = false;

  constructor(
    private cardData: CardDataService
  ) { }
  isShowContent = false;
  img: string;

  ngOnInit() {
    this.getRandomFace()
  }

  clickCard() {
    this.isShowContent = true;
    this.cardData.flippedCards.push(this);
    this.cardData.checkFlippedCards();
  }

  getRandomIndex(length) {
    return Math.floor(Math.random() * length);
  }

  getRandomFace() {
    var face;
    let randomIndex = this.getRandomIndex(this.cardData.possibleCardFaces.length);
    face = this.cardData.possibleCardFaces[randomIndex];
    this.cardData.possibleCardFaces.splice(randomIndex, 1);
    this.img = face;
  }

}
