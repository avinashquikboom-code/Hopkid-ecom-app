import React from 'react';
import { HopkidIcon, type HopkidIconName } from '../common/HopkidIcon';
import type { TodayStat } from '../../types/dashboard';

interface TodayGlanceCardProps {
  stats: TodayStat[];
  loading?: boolean;
}

const STAT_ICON: Record<TodayStat['id'], HopkidIconName> = {
  orders: 'bag',
  sales: 'rupee',
  new_customers: 'userPlus',
  returning: 'repeat',
};

export const TodayGlanceCard: React.FC<TodayGlanceCardProps> = ({
  stats,
  loading,
}) => {
  return (
    <section className="flex h-full flex-col rounded-2xl border border-[#E8E5EF] bg-white p-5 shadow-sm">
      <div className="mb-4 flex items-center justify-between">
        <h2 className="text-[17px] font-bold text-[#171322]">Today at a Glance</h2>
        <span className="rounded-full bg-[#E7F8EA] px-2.5 py-0.5 text-[11px] font-bold text-[#16A34A]">
          Updated just now
        </span>
      </div>

      {loading ? (
        <div className="h-[200px] animate-pulse rounded-xl bg-[#F8F8FC]" />
      ) : (
        <div className="grid flex-1 grid-cols-2 gap-3.5">
          {stats.map((stat) => (
            <div
              key={stat.id}
              className={`flex flex-col justify-between rounded-2xl border border-[#E8E5EF]/70 p-4 transition-transform duration-200 hover:-translate-y-0.5 ${stat.bgClass}`}
            >
              <div className="flex items-center justify-between">
                <span className="text-xs font-semibold text-[#6B7280]">
                  {stat.label}
                </span>
                <div
                  className={`flex h-9 w-9 items-center justify-center rounded-xl shadow-2xs ${stat.iconBgClass}`}
                >
                  <HopkidIcon
                    name={STAT_ICON[stat.id]}
                    className={`h-4 w-4 ${stat.iconColorClass}`}
                  />
                </div>
              </div>
              <p className="mt-3 text-2xl font-extrabold tracking-tight text-[#171322]">
                {stat.value}
              </p>
            </div>
          ))}
        </div>
      )}
    </section>
  );
};
