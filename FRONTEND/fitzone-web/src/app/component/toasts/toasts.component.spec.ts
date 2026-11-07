import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppModule } from '../../app-module';
import { ToastsComponent } from './toasts.component';

describe('ToastsComponent', () => {
  let component: ToastsComponent;
  let fixture: ComponentFixture<ToastsComponent>;

  beforeEach(async () => {
    // AppModule trae declarados todos los componentes, pipes y servicios (modo de datos de ejemplo)
    await TestBed.configureTestingModule({ imports: [AppModule] }).compileComponents();
    fixture = TestBed.createComponent(ToastsComponent);
    component = fixture.componentInstance;
  });

  it('se crea', () => {
    expect(component).toBeTruthy();
  });
});
