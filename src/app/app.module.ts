import { NgModule, APP_INITIALIZER } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouteReuseStrategy } from '@angular/router';
import { IonicModule, IonicRouteStrategy } from '@ionic/angular';
import { AppConfig } from 'src/environments/environment';
import { HttpClientModule } from '@angular/common/http';

import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';
import { RollingCardComponent } from './component/rolling-card/rolling-card.component';
import { BoardComponent } from './component/board/board.component';

// environments route
export function initConfig(appconfig: AppConfig) {
  return () => appconfig.load();
}

@NgModule({
    declarations: [AppComponent, RollingCardComponent, BoardComponent],
    imports: [
        BrowserModule,
        HttpClientModule,
        IonicModule.forRoot(),
        AppRoutingModule
    ],
    providers: [
        AppConfig,
        {
            provide: APP_INITIALIZER, useFactory: initConfig, deps: [AppConfig], multi: true
        },
    ],
    bootstrap: [AppComponent]
})
export class AppModule { }
