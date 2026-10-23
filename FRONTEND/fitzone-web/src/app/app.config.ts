import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { ApplicationConfig, provideBrowserGlobalErrorListeners } from '@angular/core';
import { provideRouter } from '@angular/router';
import { environment } from '../environments/environment';
import { authInterceptor } from './core/auth.interceptor';
import { DataService } from './core/data.service';
import { HttpDataService } from './core/http-data.service';
import { MockDataService } from './core/mock-data.service';
import { routes } from './app.routes';

export const appConfig: ApplicationConfig = {
  providers: [
    provideBrowserGlobalErrorListeners(),
    provideRouter(routes),
    provideHttpClient(withInterceptors([authInterceptor])),
    // Datos de ejemplo o API real según environment.useMock
    { provide: DataService, useClass: environment.useMock ? MockDataService : HttpDataService },
  ],
};
