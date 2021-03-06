import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { ClasificacionPageRoutingModule } from './clasificacion-routing.module';

import { ClasificacionPage } from './clasificacion.page';
import { ComponentsModule } from 'src/app/components/components.module';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    ClasificacionPageRoutingModule,
    ComponentsModule
  ],
  declarations: [ClasificacionPage]
})
export class ClasificacionPageModule {}
