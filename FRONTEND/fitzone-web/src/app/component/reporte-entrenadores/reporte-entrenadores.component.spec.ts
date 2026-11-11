import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppModule } from '../../app-module';
import { ReporteEntrenadoresComponent } from './reporte-entrenadores.component';

describe('ReporteEntrenadoresComponent', () => {
  let component: ReporteEntrenadoresComponent;
  let fixture: ComponentFixture<ReporteEntrenadoresComponent>;

  beforeEach(async () => {
    // AppModule trae declarados todos los componentes, pipes y servicios (modo de datos de ejemplo)
    await TestBed.configureTestingModule({ imports: [AppModule] }).compileComponents();
    fixture = TestBed.createComponent(ReporteEntrenadoresComponent);
    component = fixture.componentInstance;
  });

  it('se crea', () => {
    expect(component).toBeTruthy();
  });
});
