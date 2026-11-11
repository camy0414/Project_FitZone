import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppModule } from '../../app-module';
import { MiembroDetalleComponent } from './miembro-detalle.component';

describe('MiembroDetalleComponent', () => {
  let component: MiembroDetalleComponent;
  let fixture: ComponentFixture<MiembroDetalleComponent>;

  beforeEach(async () => {
    // AppModule trae declarados todos los componentes, pipes y servicios (modo de datos de ejemplo)
    await TestBed.configureTestingModule({ imports: [AppModule] }).compileComponents();
    fixture = TestBed.createComponent(MiembroDetalleComponent);
    component = fixture.componentInstance;
  });

  it('se crea', () => {
    expect(component).toBeTruthy();
  });
});
