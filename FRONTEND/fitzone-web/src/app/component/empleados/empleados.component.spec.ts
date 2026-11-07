import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppModule } from '../../app-module';
import { EmpleadosComponent } from './empleados.component';

describe('EmpleadosComponent', () => {
  let component: EmpleadosComponent;
  let fixture: ComponentFixture<EmpleadosComponent>;

  beforeEach(async () => {
    // AppModule trae declarados todos los componentes, pipes y servicios (modo de datos de ejemplo)
    await TestBed.configureTestingModule({ imports: [AppModule] }).compileComponents();
    fixture = TestBed.createComponent(EmpleadosComponent);
    component = fixture.componentInstance;
  });

  it('se crea', () => {
    expect(component).toBeTruthy();
  });
});
