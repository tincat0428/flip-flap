import { CardDataService } from 'src/app/service/card-data/card-data.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-board',
  templateUrl: './board.component.html',
  styleUrls: ['./board.component.scss'],
})
export class BoardComponent implements OnInit {

  constructor(
    public cardData: CardDataService
  ) { }

  ngOnInit() {}

}
