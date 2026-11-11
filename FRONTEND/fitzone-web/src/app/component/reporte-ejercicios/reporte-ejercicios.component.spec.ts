import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppModule } from '../../app-module';
import { ReporteEjerciciosComponent } from './reporte-ejercicios.component';

describe('ReporteEjerciciosComponent', () => {
  let component: ReporteEjerciciosComponent;
  let fixture: ComponentFixture<ReporteEjerciciosComponent>;

  beforeEach(async () => {
    // AppModule trae declarados todos los componentes, pipes y servicios (modo de datos de ejemplo)
    await TestBed.configureTestingModule({ imports: [AppModule] }).compileComponents();
    fixture = TestBed.createComponent(ReporteEjerciciosComponent);
    component = fixture.componentInstance;
  });

  it('se crea', () => {
    expect(component).toBeTruthy();
  });
});
