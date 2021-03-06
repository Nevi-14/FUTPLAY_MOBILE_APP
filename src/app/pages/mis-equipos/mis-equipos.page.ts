import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ModalController, PopoverController } from '@ionic/angular';
import { EquiposService } from 'src/app/services/equipos.service';
import { SolicitudesService } from 'src/app/services/solicitudes.service';
import { UsuariosService } from 'src/app/services/usuarios.service';
import { BuscarEquiposPage } from '../buscar-equipos/buscar-equipos.page';
import { CrearEquipoPage } from '../crear-equipo/crear-equipo.page';

@Component({
  selector: 'app-mis-equipos',
  templateUrl: './mis-equipos.page.html',
  styleUrls: ['./mis-equipos.page.scss'],
})
export class MisEquiposPage implements OnInit {
  img =  'assets/main/my-clubs.svg';
  btn1 = true;
  btn2 = false;
  constructor(
    public equiposService: EquiposService,
     public modalCtrl: ModalController, 
     public popOverCtrl: PopoverController,
      public user: UsuariosService,
       public solicitudesService:SolicitudesService,
        public router: Router
        ) { }

  ngOnInit() {

  
    console.log(this.equiposService.userclubs ,'owner');
    console.log(this.equiposService.playerClubs , 'player');
    console.log(this.equiposService.misEquipos,'equiposService.misEquipo')
    this.otrosEquipos();
  }


  misEquipos(){
    this.btn1 = true;
    this.btn2 = false;
    this.equiposService.SyncMisEquipos(this.user.usuarioActual.Cod_Usuario).then(resp=>{
this.equiposService.otrosEquipos = [];
      this.equiposService.misEquipos = resp;
    })
  }
  otrosEquipos(){
    this.btn1 = false;
    this.btn2 = true;
    this.equiposService.misEquipos = [];
    this.equiposService.SyncOtrosEquipos(this.user.usuarioActual.Cod_Usuario).then(resp=>{
console.log('resp', resp)
      this.equiposService.otrosEquipos = resp;
    })
  }
  async crearEquipo(){
    let modal = await this.modalCtrl.create({
      component:CrearEquipoPage,
      cssClass:'my-custom-class',
      id:'create-modal'
    });

    await modal.present();
    const { data } = await modal.onDidDismiss();
 
    if(data !== undefined ){
      console.log(data,'data')
      this.modalCtrl.dismiss(data, null, "create");
    
    }

  }

  async buscarEquipos(){
    let modal = await this.modalCtrl.create({
      component:BuscarEquiposPage,
      cssClass:'my-custom-class'

    })

    return modal.present();
  }

  filledStars(stars:number){

    return new Array(stars)
  }
  emptyStars(stars:number){
    let value = 5 - stars;
    return new Array(value)
  }

  
  async unirseEquipo(){

    const modal = await this.modalCtrl.create({
      component:BuscarEquiposPage,
      cssClass:'my-cutom-class'
    });

    return await modal.present();
  }
seleccionarEquipo(equipo){
  this.equiposService.perfilEquipo = equipo

  this.solicitudesService.syncGetSolicitudesEquipos(this.equiposService.perfilEquipo.Cod_Equipo, true, true,true);
  this.equiposService.SyncJugadoresEquipos( equipo.Cod_Equipo).then( jugadores =>{
    this.equiposService.jugadoresPerfilEquipo = []
    this.equiposService.jugadoresPerfilEquipo = jugadores;

    this.modalCtrl.dismiss({
      equipo:equipo
    });
    
  })

}
  cerrarModal(){
    this.modalCtrl.dismiss();
  }
  async buscarJugadores(){

    const modal = await this.modalCtrl.create({
      component:BuscarEquiposPage,
      cssClass:'my-cutom-class'
    });

     await modal.present();

     const { data } = await modal.onWillDismiss();
if(data != undefined){
  
}
  }

}
