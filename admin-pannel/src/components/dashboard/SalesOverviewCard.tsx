import React from 'react';
import {
  ResponsiveContainer,
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
} from 'recharts';
import { TrendingUp } from 'lucide-react';
import type { DateRangeKey, SalesPoint } from '../../types/dashboard';

interface SalesOverviewCardProps {
  total: string;
  growth: string;
  comparisonText: string;
  data: SalesPoint[];
  dateRange: DateRangeKey;
  onDateRangeChange: (range: DateRangeKey) => void;
  loading?: boolean;
}

const formatYAxis = (value: number) => {
  if (value >= 100000) return `₹${(value / 100000).toFixed(1)}L`;
  if (value >= 1000) return `₹${Math.round(value / 1000)}k`;
  return `₹${value}`;
};

export const SalesOverviewCard: React.FC<SalesOverviewCardProps> = ({
  total,
  growth,
  comparisonText,
  data,
  dateRange,
  onDateRangeChange,
  loading,
}) => {
  return (
    <section className="flex h-full flex-col rounded-2xl border border-[#E8E5EF] bg-white p-5 shadow-sm">
      {/* Header */}
      <div className="flex flex-wrap items-start justify-between gap-3">
        <div>
          <h2 className="text-[17px] font-bold text-[#171322]">Sales Overview</h2>
          <div className="mt-1.5 flex flex-wrap items-baseline gap-2.5">
            <span className="text-2xl font-extrabold tracking-tight text-[#171322]">
              {total}
            </span>
            <span className="inline-flex items-center gap-1 rounded-full bg-[#E7F8EA] px-2.5 py-0.5 text-xs font-bold text-[#16A34A]">
              <TrendingUp className="h-3.5 w-3.5" />
              {growth}
            </span>
            <span className="text-xs font-medium text-[#6B7280]">{comparisonText}</span>
          </div>
        </div>

        <select
          value={dateRange}
          onChange={(e) => onDateRangeChange(e.target.value as DateRangeKey)}
          aria-label="Select sales date range"
          className="h-9 rounded-xl border border-[#E8E5EF] bg-[#F8F8FC] px-3 text-xs font-semibold text-[#171322] transition-colors hover:border-[#8B35D1] focus:border-[#6A0DAD] focus:outline-none"
        >
          <option value="7d">Last 7 Days</option>
          <option value="30d">Last 30 Days</option>
          <option value="90d">Last 90 Days</option>
          <option value="1y">This Year</option>
        </select>
      </div>

      {/* Area Chart */}
      <div className="mt-5 h-[280px] w-full flex-1">
        {loading ? (
          <div className="h-full w-full animate-pulse rounded-xl bg-[#F8F8FC]" />
        ) : data.length === 0 ? (
          <div className="flex h-full items-center justify-center rounded-xl bg-[#F8F8FC] text-sm text-[#6B7280]">
            No sales data available for this period.
          </div>
        ) : (
          <ResponsiveContainer width="100%" height="100%">
            <AreaChart
              data={data}
              margin={{ top: 10, right: 12, left: -10, bottom: 0 }}
            >
              <defs>
                <linearGradient id="hopkidSalesArea" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="5%" stopColor="#6A0DAD" stopOpacity={0.35} />
                  <stop offset="65%" stopColor="#8B35D1" stopOpacity={0.12} />
                  <stop offset="95%" stopColor="#F4EAFE" stopOpacity={0.02} />
                </linearGradient>
              </defs>
              <CartesianGrid
                strokeDasharray="4 4"
                vertical={false}
                stroke="#E8E5EF"
              />
              <XAxis
                dataKey="date"
                axisLine={false}
                tickLine={false}
                tick={{ fill: '#6B7280', fontSize: 12, fontWeight: 500 }}
                dy={8}
              />
              <YAxis
                axisLine={false}
                tickLine={false}
                tickFormatter={formatYAxis}
                tick={{ fill: '#6B7280', fontSize: 12, fontWeight: 500 }}
              />
              <Tooltip
                contentStyle={{
                  backgroundColor: '#FFFFFF',
                  borderColor: '#E8E5EF',
                  borderRadius: '14px',
                  boxShadow: '0 10px 25px -5px rgba(106, 13, 173, 0.15)',
                  padding: '10px 14px',
                }}
                labelStyle={{
                  color: '#171322',
                  fontWeight: 700,
                  marginBottom: '4px',
                  fontSize: '12px',
                }}
                formatter={(value) => [
                  `₹${Number(value ?? 0).toLocaleString('en-IN')}`,
                  'Sales',
                ]}
              />
              <Area
                type="monotone"
                dataKey="sales"
                stroke="#6A0DAD"
                strokeWidth={3}
                fillOpacity={1}
                fill="url(#hopkidSalesArea)"
                activeDot={{
                  r: 6,
                  fill: '#6A0DAD',
                  stroke: '#FFFFFF',
                  strokeWidth: 2,
                }}
              />
            </AreaChart>
          </ResponsiveContainer>
        )}
      </div>
    </section>
  );
};
