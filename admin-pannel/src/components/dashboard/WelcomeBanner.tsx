import React from 'react';
import { HopkidIcon } from '../common/HopkidIcon';

export const WelcomeBanner: React.FC = () => {
  return (
    <section className="relative overflow-hidden rounded-2xl border border-[#E8E5EF] bg-gradient-to-r from-[#F4EAFE] via-[#F7ECFF] to-[#FCE7F3] px-6 py-5 shadow-sm">
      {/* Decorative soft clouds & confetti */}
      <div className="pointer-events-none absolute -top-10 -left-10 h-36 w-36 rounded-full bg-white/45 blur-2xl" />
      <div className="pointer-events-none absolute -bottom-12 left-1/3 h-32 w-44 rounded-full bg-white/50 blur-2xl" />
      <div className="pointer-events-none absolute -top-8 right-12 h-28 w-28 rounded-full bg-[#E9D5FF]/50 blur-xl" />

      {/* Confetti dots */}
      <span className="pointer-events-none absolute top-4 left-[30%] h-2 w-2 rounded-full bg-[#6A0DAD]/40" />
      <span className="pointer-events-none absolute bottom-5 left-[24%] h-2.5 w-2.5 rotate-45 rounded-xs bg-[#EC4899]/45" />
      <span className="pointer-events-none absolute top-6 right-[28%] h-2 w-2 rounded-full bg-[#F59E0B]/55" />
      <span className="pointer-events-none absolute bottom-4 right-[22%] h-2 w-2 rounded-full bg-[#3B82F6]/45" />
      <span className="pointer-events-none absolute top-1/2 right-8 h-1.5 w-1.5 rounded-full bg-[#8B35D1]/50" />

      <div className="relative z-10 flex flex-col items-center justify-between gap-5 md:flex-row">
        {/* Left: Greeting */}
        <div className="text-center md:text-left">
          <div className="inline-flex items-center gap-1.5 rounded-full bg-white/80 px-3 py-1 text-[11px] font-semibold text-[#6A0DAD] shadow-2xs ring-1 ring-[#E8E5EF]">
            <HopkidIcon name="sparkles" className="h-3.5 w-3.5 text-[#8B35D1]" />
            Hopkid Storefront Live
          </div>
          <h1 className="mt-2.5 text-2xl font-extrabold tracking-tight text-[#171322] sm:text-[26px]">
            Hello Admin!
          </h1>
          <p className="mt-1 text-sm font-medium text-[#6B7280]">
            Here&apos;s what&apos;s happening at Hopkid today.
          </p>
        </div>

        {/* Center: Happy children wearing colorful kids' clothes */}
        <div className="relative flex items-center justify-center">
          <div className="relative h-28 w-64 overflow-hidden rounded-2xl bg-[#F4EAFE] sm:h-32 sm:w-80">
            <img
              src="/images/welcome-kids.jpg"
              alt="Happy children wearing colorful Hopkid clothing"
              className="h-full w-full object-cover object-top mix-blend-multiply"
            />
            <div className="pointer-events-none absolute inset-0 bg-gradient-to-r from-[#F6ECFF] via-transparent to-[#FAE9F7]" />
          </div>
        </div>

        {/* Right: Crown & Celebration callout */}
        <div className="flex flex-col items-center text-center md:items-end md:text-right">
          <div className="mb-1.5 flex h-10 w-10 items-center justify-center rounded-xl bg-white/85 shadow-sm ring-1 ring-[#E8E5EF]">
            <HopkidIcon name="crown" active className="h-5 w-5 text-[#6A0DAD]" />
          </div>
          <p className="text-xs font-semibold tracking-wide text-[#6B7280]">
            Every Moment is a
          </p>
          <p className="bg-gradient-to-r from-[#6A0DAD] to-[#DB2777] bg-clip-text text-xl font-extrabold tracking-tight text-transparent">
            Celebration
          </p>
        </div>
      </div>
    </section>
  );
};
