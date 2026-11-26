import React from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowUpRight } from 'lucide-react';
import type { InventoryItem, StockStatus } from '../../types/dashboard';

interface InventoryStatusCardProps {
  items: InventoryItem[];
  loading?: boolean;
}

const STOCK_BADGE: Record<StockStatus, string> = {
  'In Stock': 'bg-[#E7F8EA] text-[#15803D]',
  'Low Stock': 'bg-[#FFF3DF] text-[#B45309]',
  'Out of Stock': 'bg-[#FCE7F3] text-[#BE185D]',
};

export const InventoryStatusCard: React.FC<InventoryStatusCardProps> = ({
  items,
  loading,
}) => {
  const navigate = useNavigate();

  return (
    <section className="flex h-full flex-col rounded-2xl border border-[#E8E5EF] bg-white p-5 shadow-sm">
      <div className="mb-4 flex items-center justify-between">
        <h2 className="text-[17px] font-bold text-[#171322]">Inventory Status</h2>
        <button
          type="button"
          onClick={() => navigate('/inventory')}
          className="inline-flex items-center gap-1 rounded-lg bg-[#F4EAFE] px-3 py-1.5 text-xs font-bold text-[#6A0DAD] transition-colors hover:bg-[#E9D5FF]"
        >
          View All
          <ArrowUpRight className="h-3.5 w-3.5" />
        </button>
      </div>

      {loading ? (
        <div className="h-[200px] animate-pulse rounded-xl bg-[#F8F8FC]" />
      ) : items.length === 0 ? (
        <div className="flex h-[200px] items-center justify-center rounded-xl bg-[#F8F8FC] text-sm text-[#6B7280]">
          No inventory items to display.
        </div>
      ) : (
        <div className="space-y-3">
          {items.map((item) => (
            <div
              key={item.id}
              onClick={() => navigate('/inventory')}
              className="flex cursor-pointer items-center justify-between gap-3 rounded-xl border border-[#E8E5EF]/70 bg-[#F8F8FC]/60 p-3 transition-all hover:border-[#8B35D1]/40 hover:bg-[#F4EAFE]/40"
            >
              <div className="flex items-center gap-3 min-w-0">
                <div
                  className={`flex h-11 w-11 shrink-0 items-center justify-center rounded-xl text-xl shadow-2xs ${item.colorSwatch}`}
                >
                  {item.emoji}
                </div>
                <div className="min-w-0">
                  <p className="truncate text-[13.5px] font-bold text-[#171322]">
                    {item.name}
                  </p>
                  <p className="mt-0.5 text-xs font-medium text-[#6B7280]">
                    SKU: <span className="font-semibold text-[#171322]">{item.sku}</span>
                  </p>
                </div>
              </div>

              <div className="flex shrink-0 items-center gap-3">
                <span
                  className={`inline-flex rounded-full px-2.5 py-0.5 text-[11px] font-bold ${STOCK_BADGE[item.status]}`}
                >
                  {item.status}
                </span>
                <div className="w-10 text-right">
                  <p className="text-sm font-extrabold text-[#171322]">
                    {item.quantity}
                  </p>
                  <p className="text-[10px] font-medium text-[#6B7280]">qty</p>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </section>
  );
};
