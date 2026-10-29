import { ChangeDetectionStrategy, Component, OnInit, computed, inject, input, output, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../../core/auth.service';
import { DataService } from '../../../core/data.service';
import { LIMITES, TIPOS_SANGRE } from '../../../core/limites';
import { InfoMedica, Miembro, NuevoMiembro, Sede } from '../../../core/models';
import { ModalComponent } from '../../../shared/components/modal/modal.component';
import { mensajeError } from '../../../shared/utils/util';


@Component({
  selector: 'app-miembro-form',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [ReactiveFormsModule, ModalComponent],
  templateUrl: './miembro-form.component.html',
})
export class MiembroFormComponent implements OnInit {
  private data = inject(DataService);
  private fb = inject(FormBuilder);
  readonly usuario = inject(AuthService).usuario;

  readonly miembro = input<Miembro | null>(null);
  readonly infoMedica = input<InfoMedica | null>(null);
  /** Emite el mensaje de confirmación de la operación. */
  readonly guardado = output<string>();
  readonly cerrar = output<void>();

  readonly esEdicion = computed(() => this.miembro() !== null);
  readonly esAdmin = computed(() => this.usuario()?.rol === 'ADMIN_SISTEMA');
  readonly tiposSangre = TIPOS_SANGRE;
  readonly max = { ...LIMITES.persona, ...LIMITES.infoMedica };
  readonly sedes = signal<Sede[]>([]);
  readonly conMedica = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');

  readonly form = this.fb.nonNullable.group({
    primerNombre: ['', [Validators.required, Validators.maxLength(LIMITES.persona.nombre)]],
    segundoNombre: ['', Validators.maxLength(LIMITES.persona.nombre)],
    primerApellido: ['', [Validators.required, Validators.maxLength(LIMITES.persona.apellido)]],
    segundoApellido: ['', Validators.maxLength(LIMITES.persona.apellido)],
    telefono: ['', [Validators.required, Validators.maxLength(LIMITES.persona.telefono)]],
    correo: ['', [Validators.required, Validators.email, Validators.maxLength(LIMITES.persona.correo)]],
    idSede: [0, Validators.min(1)],
    contactoEmergencia: ['', Validators.maxLength(LIMITES.infoMedica.contactoEmergencia)],
    tipoSangre: [''],
    condicionMedica: ['', Validators.maxLength(LIMITES.infoMedica.condicionMedica)],
  });

  ngOnInit() {
    if (this.esAdmin()) this.data.sedes().subscribe((l) => this.sedes.set(l));
    const m = this.miembro();
    const i = this.infoMedica();
    this.form.reset({
      primerNombre: m?.primerNombre ?? '', segundoNombre: m?.segundoNombre ?? '',
      primerApellido: m?.primerApellido ?? '', segundoApellido: m?.segundoApellido ?? '',
      telefono: m?.telefono ?? '', correo: m?.correo ?? '',
      idSede: m?.idSede ?? (this.esAdmin() ? 0 : (this.usuario()?.idSede ?? 0)),
      contactoEmergencia: i?.contactoEmergencia ?? '', tipoSangre: i?.tipoSangre ?? '', condicionMedica: i?.condicionMedica ?? '',
    });
    this.fijarMedica(i !== null);
  }
  fijarMedica(on: boolean) {
    this.conMedica.set(on);
    const c = this.form.controls;
    c.contactoEmergencia.setValidators(on
      ? [Validators.required, Validators.maxLength(LIMITES.infoMedica.contactoEmergencia)]
      : Validators.maxLength(LIMITES.infoMedica.contactoEmergencia));
    c.tipoSangre.setValidators(on ? Validators.required : null);
    c.contactoEmergencia.updateValueAndValidity();
    c.tipoSangre.updateValueAndValidity();
  }

  guardar() {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    const v = this.form.getRawValue();
    const datos: NuevoMiembro = {
      primerNombre: v.primerNombre, segundoNombre: v.segundoNombre || undefined,
      primerApellido: v.primerApellido, segundoApellido: v.segundoApellido || undefined,
      telefono: v.telefono, correo: v.correo, idSede: +v.idSede,
      infoMedica: this.conMedica()
        ? { contactoEmergencia: v.contactoEmergencia, tipoSangre: v.tipoSangre, condicionMedica: v.condicionMedica || undefined }
        : undefined,
    };
    const m = this.miembro();
    this.enviando.set(true); this.error.set('');
    (m ? this.data.editarMiembro(m.idMiembro, datos) : this.data.crearMiembro(datos)).subscribe({
      next: (msg) => { this.enviando.set(false); this.guardado.emit(msg); },
      error: (e) => { this.enviando.set(false); this.error.set(mensajeError(e)); },
    });
  }
}
