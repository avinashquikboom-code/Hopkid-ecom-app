import React from 'react';
import { useNavigate } from 'react-router-dom';
import { HopkidIcon, type HopkidIconName } from '../common/HopkidIcon';

const QUICK_ACTIONS: {
  label: string;
  to: string;
  bg: string;
  iconBg: string;
  iconName: HopkidIconName;
}[] = [
  {
    label: 'Add Product',
    to: '/products/new',
    bg: 'bg-[#F4EAFE]',
    iconBg: 'bg-[#6A0DAD]',
    iconName: 'plusCircle',
  },
  {
    label: 'Manage Orders',
    to: '/orders',
    bg: 'bg-[#E8F2FF]',
    iconBg: 'bg-[#2563EB]',
    iconName: 'bag',
  },
  {
    label: 'Update Inventory',
    to: '/inventory',
    bg: 'bg-[#FFF3DF]',
    iconBg: 'bg-[#D97706]',
    iconName: 'inventory',
  },
  {
    label: 'Create Coupon',
    to: '/discounts',
    bg: 'bg-[#FCE7F3]',
    iconBg: 'bg-[#DB2777]',
    iconName: 'discounts',
  },
  {
    label: 'Upload Banner',
    to: '/banners',
    bg: 'bg-[#E7F8EA]',
    iconBg: 'bg-[#16A34A]',
    iconName: 'upload',
  },
  {
    label: 'View Reports',
    to: '/reports/sales',
    bg: 'bg-[#F0E5FC]',
    iconBg: 'bg-[#8B35D1]',
    iconName: 'reports',
  },
];

export const QuickActionsCard: React.FC = () => {
  const navigate = useNavigate();

  return (
    <section className="rounded-2xl border border-[#E8E5EF] bg-white p-5 shadow-sm">
      <div className="mb-4 flex items-center justify-between">
        <h2 className="text-[17px] font-bold text-[#171322]">Quick Actions</h2>
        <span className="text-xs font-medium text-[#6B7280]">
          One-click store shortcuts
        </span>
      </div>

      <div className="grid grid-cols-2 gap-3.5 sm:grid-cols-3 lg:grid-cols-6">
        {QUICK_ACTIONS.map(({ label, to, bg, iconBg, iconName }) => (
          <button
            key={label}
            type="button"
            onClick={() => navigate(to)}
            className={`group flex flex-col items-center justify-center gap-2.5 rounded-2xl border border-[#E8E5EF]/70 p-4 text-center transition-all duration-200 hover:-translate-y-1 hover:shadow-md ${bg}`}
          >
            <div
              className={`flex h-11 w-11 items-center justify-center rounded-xl text-white shadow-sm transition-transform duration-200 group-hover:scale-110 ${iconBg}`}
            >
              <HopkidIcon name={iconName} className="h-5 w-5" />
            </div>
            <span className="text-xs font-bold text-[#171322] leading-tight">
              {label}
            </span>
          </button>
        ))}
      </div>
    </section>
  );
};
