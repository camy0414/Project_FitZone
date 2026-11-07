import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppModule } from '../../app-module';
import { ReporteOcupacionComponent } from './reporte-ocupacion.component';

describe('ReporteOcupacionComponent', () => {
  let component: ReporteOcupacionComponent;
  let fixture: ComponentFixture<ReporteOcupacionComponent>;

  beforeEach(async () => {
    // AppModule trae declarados todos los componentes, pipes y servicios (modo de datos de ejemplo)
    await TestBed.configureTestingModule({ imports: [AppModule] }).compileComponents();
    fixture = TestBed.createComponent(ReporteOcupacionComponent);
    component = fixture.componentInstance;
  });

  it('se crea', () => {
    expect(component).toBeTruthy();
  });
});
