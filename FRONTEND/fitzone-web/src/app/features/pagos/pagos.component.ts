import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { DataService } from '../../core/data.service';
import { Pago } from '../../core/models';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { CopPipe } from '../../shared/pipes/cop.pipe';
import { FechaPipe } from '../../shared/pipes/fecha.pipe';
import { SearchService } from '../../shared/services/search.service';

@Component({
  selector: 'app-pagos',
  imports: [PanelComponent, FilaComponent, VacioComponent, CopPipe, FechaPipe],
  templateUrl: './pagos.component.html',
})
export class PagosComponent implements OnInit {
  private data = inject(DataService);
  private buscador = inject(SearchService);

  readonly cargando = signal(true);
  readonly lista = signal<Pago[]>([]);
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((p) => `${p.miembro} ${p.metodo}`.toLowerCase().includes(t));
  });
  readonly total = computed(() => this.visibles().reduce((a, p) => a + p.monto, 0));

  ngOnInit() {
    this.buscador.texto.set('');
    this.data.pagos().subscribe((l) => { this.lista.set(l); this.cargando.set(false); });
  }
}
