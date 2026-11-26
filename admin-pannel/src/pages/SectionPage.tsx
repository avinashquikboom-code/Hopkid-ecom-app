import React from 'react';
import { useNavigate } from 'react-router-dom';
import { HopkidIcon } from '../components/common/HopkidIcon';

interface SectionPageProps {
  title: string;
  description: string;
}

export const SectionPage: React.FC<SectionPageProps> = ({ title, description }) => {
  const navigate = useNavigate();

  return (
    <div className="space-y-5">
      <div className="flex flex-wrap items-center justify-between gap-3 rounded-2xl border border-[#E8E5EF] bg-white p-6 shadow-sm">
        <div>
          <div className="inline-flex items-center gap-1.5 rounded-full bg-[#F4EAFE] px-3 py-1 text-xs font-bold text-[#6A0DAD]">
            <HopkidIcon name="sparkles" className="h-3.5 w-3.5" />
            Hopkid Admin Module
          </div>
          <h1 className="mt-2.5 text-2xl font-extrabold text-[#171322]">{title}</h1>
          <p className="mt-1 text-sm text-[#6B7280]">{description}</p>
        </div>

        <button
          type="button"
          onClick={() => navigate('/')}
          className="inline-flex items-center gap-2 rounded-xl bg-[#6A0DAD] px-4 py-2.5 text-xs font-bold text-white shadow-sm transition-colors hover:bg-[#4B087E]"
        >
          <HopkidIcon name="arrowLeft" className="h-4 w-4" />
          Back to Dashboard
        </button>
      </div>

      <div className="rounded-2xl border border-dashed border-[#D8B4FE] bg-[#F4EAFE]/40 p-10 text-center">
        <p className="text-sm font-semibold text-[#171322]">
          {title} workspace is ready for backend API wiring.
        </p>
        <p className="mt-1 text-xs text-[#6B7280]">
          Navigation and routing are active. Use the sidebar or Quick Actions to
          switch between modules.
        </p>
      </div>
    </div>
  );
};
