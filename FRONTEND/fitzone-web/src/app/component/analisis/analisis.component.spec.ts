import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppModule } from '../../app-module';
import { AnalisisComponent } from './analisis.component';

describe('AnalisisComponent', () => {
  let component: AnalisisComponent;
  let fixture: ComponentFixture<AnalisisComponent>;

  beforeEach(async () => {
    // AppModule trae declarados todos los componentes, pipes y servicios (modo de datos de ejemplo)
    await TestBed.configureTestingModule({ imports: [AppModule] }).compileComponents();
    fixture = TestBed.createComponent(AnalisisComponent);
    component = fixture.componentInstance;
  });

  it('se crea', () => {
    expect(component).toBeTruthy();
  });
});
