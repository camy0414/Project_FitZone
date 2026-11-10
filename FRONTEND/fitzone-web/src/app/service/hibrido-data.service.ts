import { Injectable, inject } from '@angular/core';
import { tap } from 'rxjs';
import { FiltroReporte } from '../model/reporte';
import { EdicionProgreso, NuevoProgreso } from '../model/progreso';
import { EdicionRutina, NuevaRutina } from '../model/rutina';
import { HttpDataService } from './http-data.service';
import { MockDataService } from './mock-data.service';

@Injectable()
export class HibridoDataService extends HttpDataService {
  private ejemplo = inject(MockDataService);

  override miembros() { return super.miembros().pipe(tap((l) => this.ejemplo.sincronizarMiembros(l))); }
  override miembrosCadena() { return super.miembrosCadena().pipe(tap((l) => this.ejemplo.sincronizarMiembros(l))); }

  override reporteIngresos(f: FiltroReporte) { return this.ejemplo.reporteIngresos(f); }
  override reporteMantenimientos(f: FiltroReporte) { return this.ejemplo.reporteMantenimientos(f); }

  override rutinas() { return this.ejemplo.rutinas(); }
  override crearRutina(d: NuevaRutina) { return this.ejemplo.crearRutina(d); }
  override editarRutina(id: string, d: EdicionRutina) { return this.ejemplo.editarRutina(id, d); }
  override cambiarEstadoRutina(id: string, activa: boolean) { return this.ejemplo.cambiarEstadoRutina(id, activa); }
  override eliminarRutina(id: string) { return this.ejemplo.eliminarRutina(id); }
  override progresos() { return this.ejemplo.progresos(); }
  override crearProgreso(d: NuevoProgreso) { return this.ejemplo.crearProgreso(d); }
  override editarProgreso(id: string, d: EdicionProgreso) { return this.ejemplo.editarProgreso(id, d); }
  override eliminarProgreso(id: string) { return this.ejemplo.eliminarProgreso(id); }
  override analisisMongo() { return this.ejemplo.analisisMongo(); }
}