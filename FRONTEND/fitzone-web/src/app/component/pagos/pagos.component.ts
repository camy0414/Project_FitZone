import { ChangeDetectionStrategy, Component, OnInit, computed, inject, signal } from '@angular/core';
import { DataService } from '../../service/data.service';
import { Pago } from '../../model/pago';
import { BuscadorService } from '../../service/buscador';

@Component({
  selector: 'app-pagos',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './pagos.component.html',
  styleUrl: './pagos.component.css',
})
export class PagosComponent implements OnInit {
  private data = inject(DataService);
  private buscador = inject(BuscadorService);

  readonly cargando = signal(true);
  readonly lista = signal<Pago[]>([]);
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((p) => `${p.miembro} ${p.metodo}`.toLowerCase().includes(t));
  });
  readonly total = computed(() => this.visibles().reduce((a, p) => a + p.monto, 0));

  ngOnInit() {
    this.buscador.texto.set('');
    this.data.pagos().subscribe({ next: (l) => { this.lista.set(l); this.cargando.set(false); }, error: () => this.cargando.set(false) });
  }
}
