import {  NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { RivalesPageRoutingModule } from './rivales-routing.module';

import { RivalesPage } from './rivales.page';
import { PipesModule } from 'src/app/pipes/pipes.module';
import { ComponentsModule } from 'src/app/components/components.module';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RivalesPageRoutingModule,
    PipesModule,
    ComponentsModule
  ],
  declarations: [RivalesPage]
})
export class RivalesPageModule {}
