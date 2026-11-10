import { ChangeDetectionStrategy, Component, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { environment } from '../../../environments/environment';
import { AuthService } from '../../service/auth';
import { primeraRuta } from '../../service/menu';
import { mensajeError } from '../../service/util';

@Component({
  selector: 'app-login',
  standalone: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './login.component.html',
  styleUrl: './login.component.css',
})
export class LoginComponent {
  private fb = inject(FormBuilder);
  private auth = inject(AuthService);
  private router = inject(Router);

  /** Login contra el backend (usuarios de la base de datos) o con los usuarios de ejemplo. */
  readonly loginReal = this.auth.loginReal;
  readonly cargando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    correo: ['', [Validators.required, Validators.email]],
    clave: ['', [Validators.required]],
  });

  /**
   * Accesos rápidos por rol. Con el backend llenan solo el correo (usuarios de FitZone Chapinero
   * del script 02_insercion_datos.sql); con los datos de ejemplo llenan también la contraseña.
   */
  readonly demo: [string, string][] = this.loginReal
    ? [
        ['Administrador', 'sebastian.perez@fitzone.com.co'],
        ['Gerente', 'sofia.sanchez@fitzone.com.co'],
        ['Recepción', 'viviana.ospina@fitzone.com.co'],
        ['Entrenador', 'nicolas.mendoza@fitzone.com.co'],
      ]
    : [
        ['Administrador', 'admin@fitzone.example.com'],
        ['Gerente', 'gerente.chapinero@fitzone.example.com'],
        ['Recepción', 'recepcion.chapinero@fitzone.example.com'],
        ['Entrenador', 'mateo.alvarado@fitzone.example.com'],
      ];

  usarDemo(correo: string) {
    this.form.setValue({ correo, clave: this.loginReal ? '' : 'Fitzone2026*' });
  }

  entrar() {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }
    this.cargando.set(true);
    this.error.set('');
    const { correo, clave } = this.form.getRawValue();
    this.auth.login(correo, clave).subscribe({
      next: (r) => this.router.navigateByUrl(primeraRuta(r.usuario.rol)),
      error: (e) => {
        this.cargando.set(false);
        if (e?.status === 0) this.error.set(`No se pudo conectar con el backend (${environment.apiUrl}). Revisa que esté corriendo.`);
        else if (e?.status === 401) this.error.set(typeof e.error === 'string' && e.error ? e.error : e?.error?.mensaje ?? 'Correo o contraseña incorrectos.');
        else this.error.set(mensajeError(e));
      },
    });
  }
}