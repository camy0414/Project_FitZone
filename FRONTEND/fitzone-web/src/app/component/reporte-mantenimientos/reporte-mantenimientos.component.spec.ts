import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppModule } from '../../app-module';
import { ReporteMantenimientosComponent } from './reporte-mantenimientos.component';

describe('ReporteMantenimientosComponent', () => {
  let component: ReporteMantenimientosComponent;
  let fixture: ComponentFixture<ReporteMantenimientosComponent>;

  beforeEach(async () => {
    // AppModule trae declarados todos los componentes, pipes y servicios (modo de datos de ejemplo)
    await TestBed.configureTestingModule({ imports: [AppModule] }).compileComponents();
    fixture = TestBed.createComponent(ReporteMantenimientosComponent);
    component = fixture.componentInstance;
  });

  it('se crea', () => {
    expect(component).toBeTruthy();
  });
});
