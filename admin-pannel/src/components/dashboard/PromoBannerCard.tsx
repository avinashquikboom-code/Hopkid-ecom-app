import React from 'react';
import { useNavigate } from 'react-router-dom';
import { HopkidIcon } from '../common/HopkidIcon';

export const PromoBannerCard: React.FC = () => {
  const navigate = useNavigate();

  return (
    <section className="relative overflow-hidden rounded-2xl border border-[#E8E5EF] bg-gradient-to-br from-[#F0E5FC] via-[#F4EAFE] to-[#FCE7F3] p-5 shadow-sm">
      <span className="pointer-events-none absolute top-3 right-12 h-2 w-2 rounded-full bg-[#6A0DAD]/40" />
      <span className="pointer-events-none absolute top-10 right-5 h-2 w-2 rotate-45 rounded-xs bg-[#EC4899]/50" />
      <span className="pointer-events-none absolute bottom-4 left-1/2 h-2 w-2 rounded-full bg-[#F59E0B]/55" />

      <div className="relative z-10 flex items-center justify-between gap-4">
        <div className="max-w-[58%]">
          <div className="mb-2 inline-flex items-center gap-1.5 rounded-full bg-white/85 px-2.5 py-1 text-[11px] font-bold text-[#6A0DAD] shadow-2xs">
            <HopkidIcon name="crown" active className="h-3.5 w-3.5 text-[#6A0DAD]" />
            Featured Banner
          </div>
          <h3 className="text-lg font-extrabold text-[#171322] leading-snug">
            New Collection
          </h3>
          <p className="mt-1 text-xs font-medium text-[#6B7280] leading-relaxed">
            Trendy Looks for Your Little Ones
          </p>

          <button
            type="button"
            onClick={() => navigate('/banners')}
            className="mt-4 inline-flex items-center gap-1.5 rounded-xl bg-[#6A0DAD] px-3.5 py-2 text-xs font-bold text-white shadow-sm transition-all hover:bg-[#4B087E] hover:shadow-md"
          >
            Manage Banner
            <HopkidIcon name="arrowRight" className="h-3.5 w-3.5" />
          </button>
        </div>

        <div className="relative h-32 w-32 shrink-0 overflow-hidden rounded-2xl bg-[#F0E5FC] ring-1 ring-white/70 shadow-xs">
          <img
            src="/images/promo-clothes.jpg"
            alt="Kids purple hoodie and pink dress on hangers"
            className="h-full w-full object-cover mix-blend-multiply"
          />
        </div>
      </div>
    </section>
  );
};
