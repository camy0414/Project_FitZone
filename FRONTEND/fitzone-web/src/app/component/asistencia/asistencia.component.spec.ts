import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppModule } from '../../app-module';
import { AsistenciaComponent } from './asistencia.component';

describe('AsistenciaComponent', () => {
  let component: AsistenciaComponent;
  let fixture: ComponentFixture<AsistenciaComponent>;

  beforeEach(async () => {
    // AppModule trae declarados todos los componentes, pipes y servicios (modo de datos de ejemplo)
    await TestBed.configureTestingModule({ imports: [AppModule] }).compileComponents();
    fixture = TestBed.createComponent(AsistenciaComponent);
    component = fixture.componentInstance;
  });

  it('se crea', () => {
    expect(component).toBeTruthy();
  });
});
