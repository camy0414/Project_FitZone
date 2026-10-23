import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../core/auth.service';
import { DataService } from '../../core/data.service';
import { Catalogo, Empleado, ROL_LABEL, RolNombre, Sede } from '../../core/models';
import { FilaComponent } from '../../shared/components/fila/fila.component';
import { ModalComponent } from '../../shared/components/modal/modal.component';
import { PanelComponent } from '../../shared/components/panel/panel.component';
import { VacioComponent } from '../../shared/components/vacio/vacio.component';
import { SearchService } from '../../shared/services/search.service';
import { ToastService } from '../../shared/services/toast.service';
import { mensajeError } from '../../shared/utils/util';

@Component({
  selector: 'app-empleados',
  imports: [ReactiveFormsModule, PanelComponent, FilaComponent, VacioComponent, ModalComponent],
  templateUrl: './empleados.component.html',
})
export class EmpleadosComponent implements OnInit {
  private data = inject(DataService);
  private toast = inject(ToastService);
  private fb = inject(FormBuilder);
  private buscador = inject(SearchService);
  private usuario = inject(AuthService).usuario;

  readonly esAdmin = computed(() => this.usuario()?.rol === 'ADMIN_SISTEMA');
  readonly cargando = signal(true);
  readonly lista = signal<Empleado[]>([]);
  readonly sedes = signal<Sede[]>([]);
  readonly roles = signal<Catalogo[]>([]);
  readonly rolLabel = (r: RolNombre) => ROL_LABEL[r];
  readonly visibles = computed(() => {
    const t = this.buscador.texto().toLowerCase();
    return this.lista().filter((e) => `${e.nombreCompleto} ${e.correo} ${e.rol} ${e.sede}`.toLowerCase().includes(t));
  });

  readonly abierto = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');
  readonly verClave = signal(false);
  readonly form = this.fb.nonNullable.group({
    primerNombre: ['', [Validators.required, Validators.maxLength(30)]],
    segundoNombre: ['', Validators.maxLength(30)],
    primerApellido: ['', [Validators.required, Validators.maxLength(30)]],
    segundoApellido: ['', Validators.maxLength(30)],
    telefono: ['', [Validators.required, Validators.maxLength(15)]],
    correo: ['', [Validators.required, Validators.email, Validators.maxLength(60)]],
    clave: ['', [Validators.required, Validators.minLength(8)]],
    idRolEmpleado: [0, Validators.min(1)],
    idSede: [0, Validators.min(1)],
  });

  ngOnInit() {
    this.buscador.texto.set('');
    this.cargar();
    if (this.esAdmin()) {
      this.data.sedes().subscribe((l) => this.sedes.set(l));
      this.data.roles().subscribe((l) => this.roles.set(l));
    }
  }
  cargar() {
    this.data.empleados().subscribe((l) => { this.lista.set(l); this.cargando.set(false); });
  }
  nuevo() { this.form.reset({ idRolEmpleado: 0, idSede: 0 }); this.error.set(''); this.verClave.set(false); this.abierto.set(true); }
  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.enviando.set(true); this.error.set('');
    const v = this.form.getRawValue();
    this.data.crearEmpleado({ ...v, idRolEmpleado: +v.idRolEmpleado, idSede: +v.idSede }).subscribe({
      next: (m) => { this.enviando.set(false); this.abierto.set(false); this.toast.ok(m); this.cargar(); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
  alternar(e: Empleado) {
    this.data.cambiarEstadoEmpleado(e.idEmpleado, !e.activo).subscribe({
      next: (m) => { this.toast.ok(m); this.cargar(); },
      error: (err) => this.toast.error(mensajeError(err)),
    });
  }
}
