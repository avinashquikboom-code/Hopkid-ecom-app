import React from 'react';
import { ResponsiveContainer, PieChart, Pie, Cell, Tooltip } from 'recharts';
import type { OrderStatusItem } from '../../types/dashboard';

interface OrderStatusCardProps {
  totalOrders: number;
  statuses: OrderStatusItem[];
  loading?: boolean;
}

export const OrderStatusCard: React.FC<OrderStatusCardProps> = ({
  totalOrders,
  statuses,
  loading,
}) => {
  return (
    <section className="rounded-2xl border border-[#E8E5EF] bg-white p-5 shadow-sm">
      <div className="flex items-center justify-between">
        <h2 className="text-[17px] font-bold text-[#171322]">Order Status</h2>
        <span className="rounded-full bg-[#F4EAFE] px-2.5 py-0.5 text-[11px] font-semibold text-[#6A0DAD]">
          Live Breakdown
        </span>
      </div>

      {loading ? (
        <div className="mt-4 h-[200px] animate-pulse rounded-xl bg-[#F8F8FC]" />
      ) : statuses.length === 0 ? (
        <div className="mt-4 flex h-[200px] items-center justify-center rounded-xl bg-[#F8F8FC] text-sm text-[#6B7280]">
          No order status data available.
        </div>
      ) : (
        <div className="mt-4 flex flex-col items-center gap-4 sm:flex-row sm:justify-between">
          {/* Donut Chart */}
          <div className="relative h-[185px] w-[185px] shrink-0">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={statuses}
                  dataKey="count"
                  nameKey="name"
                  cx="50%"
                  cy="50%"
                  innerRadius={56}
                  outerRadius={82}
                  paddingAngle={3}
                  stroke="none"
                >
                  {statuses.map((entry) => (
                    <Cell key={entry.name} fill={entry.color} />
                  ))}
                </Pie>
                <Tooltip
                  contentStyle={{
                    backgroundColor: '#FFFFFF',
                    borderColor: '#E8E5EF',
                    borderRadius: '12px',
                    boxShadow: '0 8px 20px -4px rgba(23, 19, 34, 0.12)',
                    fontSize: '12px',
                  }}
                  formatter={(value, name) => [
                    `${Number(value ?? 0).toLocaleString('en-IN')} orders`,
                    String(name ?? ''),
                  ]}
                />
              </PieChart>
            </ResponsiveContainer>

            {/* Center Label */}
            <div className="pointer-events-none absolute inset-0 flex flex-col items-center justify-center text-center">
              <span className="text-xl font-extrabold text-[#171322]">
                {totalOrders.toLocaleString('en-IN')}
              </span>
              <span className="text-[11px] font-semibold text-[#6B7280]">
                Total Orders
              </span>
            </div>
          </div>

          {/* Right Legend */}
          <div className="w-full flex-1 space-y-2.5">
            {statuses.map((item) => (
              <div
                key={item.name}
                className="flex items-center justify-between gap-2 text-xs"
              >
                <div className="flex items-center gap-2 min-w-0">
                  <span
                    className="h-2.5 w-2.5 shrink-0 rounded-full"
                    style={{ backgroundColor: item.color }}
                  />
                  <span className="truncate font-semibold text-[#171322]">
                    {item.name}
                  </span>
                </div>
                <div className="flex items-center gap-2 shrink-0">
                  <span className="font-bold text-[#171322]">
                    {item.count.toLocaleString('en-IN')}
                  </span>
                  <span className="w-11 text-right font-medium text-[#6B7280]">
                    {item.percentage}%
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}
    </section>
  );
};
