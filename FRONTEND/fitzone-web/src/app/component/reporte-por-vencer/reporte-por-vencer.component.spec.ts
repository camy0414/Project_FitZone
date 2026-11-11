import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppModule } from '../../app-module';
import { ReportePorVencerComponent } from './reporte-por-vencer.component';

describe('ReportePorVencerComponent', () => {
  let component: ReportePorVencerComponent;
  let fixture: ComponentFixture<ReportePorVencerComponent>;

  beforeEach(async () => {
    // AppModule trae declarados todos los componentes, pipes y servicios (modo de datos de ejemplo)
    await TestBed.configureTestingModule({ imports: [AppModule] }).compileComponents();
    fixture = TestBed.createComponent(ReportePorVencerComponent);
    component = fixture.componentInstance;
  });

  it('se crea', () => {
    expect(component).toBeTruthy();
  });
});
