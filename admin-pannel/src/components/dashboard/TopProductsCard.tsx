import React from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowUpRight, Trophy } from 'lucide-react';
import type { TopProduct } from '../../types/dashboard';

interface TopProductsCardProps {
  products: TopProduct[];
  loading?: boolean;
}

const RANK_STYLE: Record<number, string> = {
  1: 'bg-[#FEF3C7] text-[#B45309] ring-1 ring-[#FDE68A]',
  2: 'bg-[#F0E5FC] text-[#6A0DAD] ring-1 ring-[#E9D5FF]',
  3: 'bg-[#FCE7F3] text-[#BE185D] ring-1 ring-[#FBCFE8]',
};

export const TopProductsCard: React.FC<TopProductsCardProps> = ({
  products,
  loading,
}) => {
  const navigate = useNavigate();

  return (
    <section className="flex h-full flex-col rounded-2xl border border-[#E8E5EF] bg-white p-5 shadow-sm">
      <div className="mb-4 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <h2 className="text-[17px] font-bold text-[#171322]">
            Top Selling Products
          </h2>
          <Trophy className="h-4 w-4 text-[#F59E0B]" />
        </div>
        <button
          type="button"
          onClick={() => navigate('/products')}
          className="inline-flex items-center gap-1 text-xs font-bold text-[#6A0DAD] hover:text-[#4B087E]"
        >
          View All
          <ArrowUpRight className="h-3.5 w-3.5" />
        </button>
      </div>

      {loading ? (
        <div className="h-[220px] animate-pulse rounded-xl bg-[#F8F8FC]" />
      ) : products.length === 0 ? (
        <div className="flex h-[220px] items-center justify-center rounded-xl bg-[#F8F8FC] text-sm text-[#6B7280]">
          No top products found.
        </div>
      ) : (
        <div className="space-y-3">
          {products.map((product) => (
            <div
              key={product.id}
              onClick={() => navigate('/products')}
              className="flex cursor-pointer items-center justify-between gap-3 rounded-xl border border-[#E8E5EF]/70 bg-[#F8F8FC]/60 p-3 transition-all hover:border-[#8B35D1]/40 hover:bg-[#F4EAFE]/40"
            >
              <div className="flex items-center gap-3 min-w-0">
                <span
                  className={`flex h-7 w-7 shrink-0 items-center justify-center rounded-full text-xs font-extrabold ${
                    RANK_STYLE[product.rank] ?? 'bg-gray-100 text-gray-700'
                  }`}
                >
                  #{product.rank}
                </span>

                <div
                  className={`flex h-11 w-11 shrink-0 items-center justify-center rounded-xl text-xl shadow-2xs ${product.bgTint}`}
                >
                  {product.emoji}
                </div>

                <div className="min-w-0">
                  <p className="truncate text-[13.5px] font-bold text-[#171322]">
                    {product.name}{' '}
                    <span className="font-medium text-[#6B7280]">
                      ({product.variant})
                    </span>
                  </p>
                  <p className="mt-0.5 text-xs font-semibold text-[#6A0DAD]">
                    {product.sold.toLocaleString('en-IN')} Sold
                  </p>
                </div>
              </div>

              <div className="shrink-0 text-right">
                <p className="text-sm font-extrabold text-[#171322]">{product.price}</p>
                <p className="text-[11px] font-medium text-[#6B7280]">Unit price</p>
              </div>
            </div>
          ))}
        </div>
      )}
    </section>
  );
};
