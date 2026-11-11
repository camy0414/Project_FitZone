import { TestBed } from '@angular/core/testing';
import { AppModule } from '../app-module';
import { DataService } from './data.service';

describe('DataService', () => {
  let service: DataService;

  beforeEach(() => {
    TestBed.configureTestingModule({ imports: [AppModule] });
    service = TestBed.inject(DataService);
  });

  it('se crea', () => {
    expect(service).toBeTruthy();
  });
});
