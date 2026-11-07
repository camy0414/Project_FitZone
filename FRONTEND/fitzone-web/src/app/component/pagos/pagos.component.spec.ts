import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppModule } from '../../app-module';
import { PagosComponent } from './pagos.component';

describe('PagosComponent', () => {
  let component: PagosComponent;
  let fixture: ComponentFixture<PagosComponent>;

  beforeEach(async () => {
    // AppModule trae declarados todos los componentes, pipes y servicios (modo de datos de ejemplo)
    await TestBed.configureTestingModule({ imports: [AppModule] }).compileComponents();
    fixture = TestBed.createComponent(PagosComponent);
    component = fixture.componentInstance;
  });

  it('se crea', () => {
    expect(component).toBeTruthy();
  });
});
