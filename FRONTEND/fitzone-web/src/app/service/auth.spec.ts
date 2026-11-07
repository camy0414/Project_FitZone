import { TestBed } from '@angular/core/testing';
import { AppModule } from '../app-module';
import { AuthService } from './auth';

describe('AuthService', () => {
  let service: AuthService;

  beforeEach(() => {
    TestBed.configureTestingModule({ imports: [AppModule] });
    service = TestBed.inject(AuthService);
  });

  it('se crea', () => {
    expect(service).toBeTruthy();
  });
});
