import { ChangeDetectionStrategy, Component, input } from '@angular/core';
import {
  LucideActivity, LucideArrowRight, LucideBell, LucideBuilding, LucideCalendarDays,
  LucideChevronRight, LucideCircleDollarSign, LucideClipboardCheck, LucideDumbbell,
  LucideLayoutDashboard, LucideLockKeyhole, LucideLogOut, LucideMail, LucideMenu,
  LucideSearch, LucideSettings, LucideShieldCheck, LucideTrendingUp, LucideUserRoundCog,
  LucideUsers, LucideWrench, LucideX, LucideZap,
} from '@lucide/angular';

/** Envoltorio de íconos Lucide: <app-icon name="users" cls="size-5" /> */
@Component({
  selector: 'app-icon',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [
    LucideActivity, LucideArrowRight, LucideBell, LucideBuilding, LucideCalendarDays,
    LucideChevronRight, LucideCircleDollarSign, LucideClipboardCheck, LucideDumbbell,
    LucideLayoutDashboard, LucideLockKeyhole, LucideLogOut, LucideMail, LucideMenu,
    LucideSearch, LucideSettings, LucideShieldCheck, LucideTrendingUp, LucideUserRoundCog,
    LucideUsers, LucideWrench, LucideX, LucideZap,
  ],
  host: { style: 'display: contents' },
  templateUrl: './icon.component.html',
})
export class IconComponent {
  name = input.required<string>();
  cls = input('size-5');
  sw = input<number>(2);
}
