import React from 'react';
import { ResponsiveContainer, AreaChart, Area } from 'recharts';
import { HopkidIcon, type HopkidIconName } from '../common/HopkidIcon';
import type { KpiMetric } from '../../types/dashboard';

interface KpiCardsProps {
  kpis: KpiMetric[];
  loading?: boolean;
}

const CARD_STYLES: Record<
  KpiMetric['id'],
  {
    bg: string;
    iconBg: string;
    iconColor: string;
    stroke: string;
    fill: string;
    iconName: HopkidIconName;
  }
> = {
  sales: {
    bg: 'bg-gradient-to-br from-[#F4EAFE] via-[#F6E9FC] to-[#FCE7F3]',
    iconBg: 'bg-white',
    iconColor: 'text-[#6A0DAD]',
    stroke: '#6A0DAD',
    fill: '#8B35D1',
    iconName: 'cart',
  },
  orders: {
    bg: 'bg-[#FCE7F3]',
    iconBg: 'bg-white',
    iconColor: 'text-[#DB2777]',
    stroke: '#DB2777',
    fill: '#F472B6',
    iconName: 'bag',
  },
  customers: {
    bg: 'bg-[#F0E5FC]',
    iconBg: 'bg-white',
    iconColor: 'text-[#7C3AED]',
    stroke: '#7C3AED',
    fill: '#A78BFA',
    iconName: 'customers',
  },
  products: {
    bg: 'bg-[#E7F8EA]',
    iconBg: 'bg-white',
    iconColor: 'text-[#16A34A]',
    stroke: '#16A34A',
    fill: '#4ADE80',
    iconName: 'package',
  },
};

export const KpiCards: React.FC<KpiCardsProps> = ({ kpis, loading }) => {
  if (loading) {
    return (
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">
        {[1, 2, 3, 4].map((idx) => (
          <div
            key={idx}
            className="h-[138px] animate-pulse rounded-2xl border border-[#E8E5EF] bg-white p-5"
          />
        ))}
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">
      {kpis.map((kpi) => {
        const style = CARD_STYLES[kpi.id];
        const gradId = `spark-${kpi.id}`;

        return (
          <div
            key={kpi.id}
            className={`group relative overflow-hidden rounded-2xl border border-[#E8E5EF]/80 p-5 shadow-sm transition-all duration-200 hover:-translate-y-0.5 hover:shadow-md ${style.bg}`}
          >
            <div className="flex items-start justify-between gap-3">
              <div>
                <p className="text-[13px] font-semibold text-[#6B7280]">{kpi.label}</p>
                <p className="mt-1.5 text-[24px] font-extrabold tracking-tight text-[#171322]">
                  {kpi.value}
                </p>
              </div>
              <div
                className={`flex h-11 w-11 shrink-0 items-center justify-center rounded-full shadow-xs ${style.iconBg}`}
              >
                <HopkidIcon
                  name={style.iconName}
                  className={`h-5 w-5 ${style.iconColor}`}
                />
              </div>
            </div>

            <div className="mt-3 flex items-end justify-between gap-2">
              <div className="flex items-center gap-1.5">
                <span className="inline-flex items-center gap-0.5 rounded-full bg-white/80 px-2 py-0.5 text-[11.5px] font-bold text-[#16A34A] shadow-2xs">
                  <HopkidIcon name="trendingUp" className="h-3 w-3" />
                  {kpi.growth}
                </span>
                <span className="text-[11.5px] font-medium text-[#6B7280]">
                  {kpi.subtitle}
                </span>
              </div>

              <div className="h-9 w-20 shrink-0">
                <ResponsiveContainer width="100%" height="100%">
                  <AreaChart data={kpi.sparkline}>
                    <defs>
                      <linearGradient id={gradId} x1="0" y1="0" x2="0" y2="1">
                        <stop offset="5%" stopColor={style.fill} stopOpacity={0.35} />
                        <stop offset="95%" stopColor={style.fill} stopOpacity={0.0} />
                      </linearGradient>
                    </defs>
                    <Area
                      type="monotone"
                      dataKey="value"
                      stroke={style.stroke}
                      strokeWidth={2}
                      fill={`url(#${gradId})`}
                      dot={false}
                      isAnimationActive={false}
                    />
                  </AreaChart>
                </ResponsiveContainer>
              </div>
            </div>
          </div>
        );
      })}
    </div>
  );
};
