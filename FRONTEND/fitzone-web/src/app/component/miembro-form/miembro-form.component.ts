import { ChangeDetectionStrategy, Component, OnInit, computed, inject, input, output, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { AuthService } from '../../service/auth';
import { DataService } from '../../service/data.service';
import { LIMITES, MENSAJE_FORMATO, PATRONES, requerido, TIPOS_SANGRE } from '../../service/validaciones';
import { InfoMedica, Miembro, NuevoMiembro } from '../../model/miembro';
import { Sede } from '../../model/sede';
import { mensajeError } from '../../service/util';

/**
 * Formulario de miembro + info_medica (1:1 opcional). Sirve para registrar
 * (sin `miembro`) y para editar (con `miembro` e `infoMedica` actuales).
 */
@Component({
  selector: 'app-miembro-form',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './miembro-form.component.html',
  styleUrl: './miembro-form.component.css',
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
  readonly msg = MENSAJE_FORMATO;
  readonly max = { ...LIMITES.persona, ...LIMITES.infoMedica };
  readonly sedes = signal<Sede[]>([]);
  readonly conMedica = signal(false);
  readonly enviando = signal(false);
  readonly error = signal('');

  readonly form = this.fb.nonNullable.group({
    primerNombre: ['', [requerido, Validators.maxLength(LIMITES.persona.nombre), Validators.pattern(PATRONES.nombre)]],
    segundoNombre: ['', [Validators.maxLength(LIMITES.persona.nombre), Validators.pattern(PATRONES.nombre)]],
    primerApellido: ['', [requerido, Validators.maxLength(LIMITES.persona.apellido), Validators.pattern(PATRONES.nombre)]],
    segundoApellido: ['', [Validators.maxLength(LIMITES.persona.apellido), Validators.pattern(PATRONES.nombre)]],
    telefono: ['', [requerido, Validators.maxLength(LIMITES.persona.telefono), Validators.pattern(PATRONES.telefono)]],
    correo: ['', [requerido, Validators.maxLength(LIMITES.persona.correo), Validators.pattern(PATRONES.correo)]],
    idSede: [0, Validators.min(1)],
    contactoEmergencia: ['', [Validators.maxLength(LIMITES.infoMedica.contactoEmergencia), Validators.pattern(PATRONES.telefono)]],
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

  /** Si se registra info médica, contacto (un teléfono) y tipo de sangre son NOT NULL en el modelo. */
  fijarMedica(on: boolean) {
    this.conMedica.set(on);
    const c = this.form.controls;
    // sin info médica los campos se ocultan, así que no se validan
    c.contactoEmergencia.setValidators(on
      ? [requerido, Validators.maxLength(LIMITES.infoMedica.contactoEmergencia), Validators.pattern(PATRONES.telefono)]
      : null);
    c.tipoSangre.setValidators(on ? requerido : null);
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