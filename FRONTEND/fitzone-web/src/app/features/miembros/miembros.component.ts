import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { Miembro, Sede } from '../../core/models';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { ModalComponent } from '../../shared/components/modal/modal.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { SearchService } from '../../shared/services/search.service';
import { ToastService } from '../../shared/services/toast.service';
import { mensajeError } from '../../shared/utils/util';

@Component({
  selector: 'app-miembros',
  imports: [ReactiveFormsModule, PanelComponent, FilaComponent, VacioComponent, ModalComponent],
  templateUrl: './miembros.component.html',
})
export class MiembrosComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  private fb = inject(FormBuilder);
  private buscador = inject(SearchService);
  readonly usuario = inject(AuthService).usuario;

  readonly esAdmin = computed(() => this.usuario()?.rol === 'ADMIN_SISTEMA');
  readonly puedeCrear = computed(() => ['ADMIN_SISTEMA', 'RECEPCIONISTA_SEDE'].includes(this.usuario()?.rol ?? ''));
  readonly cargando = signal(true);
  readonly lista = signal<Miembro[]>([]);
  readonly sedes = signal<Sede[]>([]);
  readonly tiposSangre = ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'];
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((m) => `${m.nombreCompleto} ${m.correo} ${m.sede} ${m.planActual ?? ''}`.toLowerCase().includes(t));
  });

  readonly abierto = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly conMedica = signal(false);
  readonly form = this.fb.nonNullable.group({
    primerNombre: ['', [Validators.required, Validators.maxLength(30)]],
    segundoNombre: ['', Validators.maxLength(30)],
    primerApellido: ['', [Validators.required, Validators.maxLength(30)]],
    segundoApellido: ['', Validators.maxLength(30)],
    telefono: ['', [Validators.required, Validators.maxLength(15)]],
    correo: ['', [Validators.required, Validators.email, Validators.maxLength(60)]],
    idSede: [0, Validators.min(1)],
    contactoEmergencia: [''],
    tipoSangre: [''],
    condicionMedica: [''],
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    if (this.esAdmin()) this.data.sedes().subscribe((l) => this.sedes.set(l));
  }
  cargar() { this.data.miembros().subscribe((l) => { this.lista.set(l); this.cargando.set(false); }); }
  nuevo() {
    this.form.reset({ idSede: this.esAdmin() ? 0 : (this.usuario()?.idSede ?? 0) });
    this.conMedica.set(false); this.error.set(''); this.abierto.set(true);
  }
  alternarMedica() {
    const on = !this.conMedica();
    this.conMedica.set(on);
    const c = this.form.controls;
    for (const k of [c.contactoEmergencia, c.tipoSangre]) {
      k.setValidators(on ? Validators.required : null);
      k.updateValueAndValidity();
    }
  }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.enviando.set(true); this.error.set('');
    const v = this.form.getRawValue();
    this.data.crearMiembro({
      primerNombre: v.primerNombre, segundoNombre: v.segundoNombre || undefined,
      primerApellido: v.primerApellido, segundoApellido: v.segundoApellido || undefined,
      telefono: v.telefono, correo: v.correo, idSede: +v.idSede,
      infoMedica: this.conMedica()
        ? { contactoEmergencia: v.contactoEmergencia, tipoSangre: v.tipoSangre, condicionMedica: v.condicionMedica || undefined }
        : undefined,
    }).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
