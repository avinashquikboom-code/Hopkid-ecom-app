import React from 'react';
import { useNavigate } from 'react-router-dom';
import { HopkidIcon } from '../common/HopkidIcon';
import type { OrderBadgeStatus, RecentOrder } from '../../types/dashboard';

interface RecentOrdersCardProps {
  orders: RecentOrder[];
  loading?: boolean;
}

const STATUS_BADGE_CLASS: Record<OrderBadgeStatus, string> = {
  Delivered: 'bg-[#E7F8EA] text-[#15803D]',
  Shipped: 'bg-[#E8F2FF] text-[#1D4ED8]',
  Processing: 'bg-[#FFF3DF] text-[#B45309]',
  Pending: 'bg-[#F4EAFE] text-[#6A0DAD]',
  Cancelled: 'bg-[#FCE7F3] text-[#BE185D]',
};

export const RecentOrdersCard: React.FC<RecentOrdersCardProps> = ({
  orders,
  loading,
}) => {
  const navigate = useNavigate();

  return (
    <section className="flex h-full flex-col rounded-2xl border border-[#E8E5EF] bg-white p-5 shadow-sm">
      <div className="mb-4 flex items-center justify-between">
        <h2 className="text-[17px] font-bold text-[#171322]">Recent Orders</h2>
        <button
          type="button"
          onClick={() => navigate('/orders')}
          className="inline-flex items-center gap-1 text-xs font-bold text-[#6A0DAD] hover:text-[#4B087E]"
        >
          View All
          <HopkidIcon name="arrowUpRight" className="h-3.5 w-3.5" />
        </button>
      </div>

      {loading ? (
        <div className="h-[220px] animate-pulse rounded-xl bg-[#F8F8FC]" />
      ) : orders.length === 0 ? (
        <div className="flex h-[220px] items-center justify-center rounded-xl bg-[#F8F8FC] text-sm text-[#6B7280]">
          No matching orders found.
        </div>
      ) : (
        <div className="overflow-x-auto">
          <table className="w-full min-w-[520px] border-collapse text-left">
            <thead>
              <tr className="border-b border-[#E8E5EF] text-[11.5px] font-semibold uppercase tracking-wider text-[#6B7280]">
                <th className="pb-3 pr-3">Order ID</th>
                <th className="pb-3 pr-3">Customer</th>
                <th className="pb-3 pr-3">Amount</th>
                <th className="pb-3 pr-3">Status</th>
                <th className="pb-3 text-right">Date</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-[#E8E5EF]/70 text-[13px]">
              {orders.map((order) => (
                <tr
                  key={order.id}
                  onClick={() => navigate('/orders')}
                  className="cursor-pointer transition-colors hover:bg-[#F8F8FC]"
                >
                  <td className="py-3 pr-3 font-bold text-[#6A0DAD]">{order.id}</td>
                  <td className="py-3 pr-3">
                    <div className="flex items-center gap-2.5">
                      <span
                        className={`flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-[11px] font-bold ${order.avatarBg}`}
                      >
                        {order.customerInitials}
                      </span>
                      <span className="font-semibold text-[#171322]">
                        {order.customerName}
                      </span>
                    </div>
                  </td>
                  <td className="py-3 pr-3 font-bold text-[#171322]">{order.amount}</td>
                  <td className="py-3 pr-3">
                    <span
                      className={`inline-flex rounded-full px-2.5 py-0.5 text-[11px] font-bold ${STATUS_BADGE_CLASS[order.status]}`}
                    >
                      {order.status}
                    </span>
                  </td>
                  <td className="py-3 text-right text-xs font-medium text-[#6B7280]">
                    {order.date}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </section>
  );
};
