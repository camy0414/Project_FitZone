import { ChangeDetectionStrategy, Component, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { environment } from '../../../environments/environment';
import { AuthService } from '../../service/auth';
import { primeraRuta } from '../../service/menu';

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

  readonly mock = environment.useMock;
  readonly cargando = signal(false);
  readonly error = signal('');
  readonly form = this.fb.nonNullable.group({
    correo: ['', [Validators.required, Validators.email]],
    clave: ['', [Validators.required]],
  });

  readonly demo = [
    ['Administrador', 'admin@fitzone.example.com'],
    ['Gerente', 'gerente.chapinero@fitzone.example.com'],
    ['Recepción', 'recepcion.chapinero@fitzone.example.com'],
    ['Entrenador', 'mateo.alvarado@fitzone.example.com'],
  ];

  usarDemo(correo: string) {
    this.form.setValue({ correo, clave: 'Fitzone2026*' });
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
        this.error.set(e?.status === 0 ? 'No se pudo conectar con el servidor.' : e?.error?.message ?? e?.message ?? 'No se pudo iniciar sesión.');
      },
    });
  }
}
