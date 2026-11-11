import { Injectable, inject } from '@angular/core';
import { map, tap } from 'rxjs';
import { EdicionProgreso, NuevoProgreso } from '../model/progreso';
import { HttpDataService } from './http-data.service';
import { MockDataService } from './mock-data.service';
import { calcularAnalisis } from './analisis-rutinas';

@Injectable()
export class HibridoDataService extends HttpDataService {
  private ejemplo = inject(MockDataService);

  // Los miembros reales se copian a los datos de ejemplo para que progreso los reconozca.
  override miembros() { return super.miembros().pipe(tap((l) => this.ejemplo.sincronizarMiembros(l))); }
  override miembrosCadena() { return super.miembrosCadena().pipe(tap((l) => this.ejemplo.sincronizarMiembros(l))); }

  // ---------- MongoDB sin endpoints ----------
  override progresos() { return this.ejemplo.progresos(); }
  override crearProgreso(d: NuevoProgreso) { return this.ejemplo.crearProgreso(d); }
  override editarProgreso(id: string, d: EdicionProgreso) { return this.ejemplo.editarProgreso(id, d); }
  override eliminarProgreso(id: string) { return this.ejemplo.eliminarProgreso(id); }
  // Reportes de rutinas: mientras no exista GET /rutina/analisis se calculan con las rutinas reales
  override analisisMongo() { return this.rutinas().pipe(map(calcularAnalisis)); }
}