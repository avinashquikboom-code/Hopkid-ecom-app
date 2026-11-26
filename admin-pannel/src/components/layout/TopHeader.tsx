import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { HopkidIcon } from '../common/HopkidIcon';

interface TopHeaderProps {
  onOpenMobileSidebar: () => void;
  searchQuery: string;
  onSearchChange: (value: string) => void;
}

export const TopHeader: React.FC<TopHeaderProps> = ({
  onOpenMobileSidebar,
  searchQuery,
  onSearchChange,
}) => {
  const navigate = useNavigate();
  const [showNotifications, setShowNotifications] = useState(false);
  const [showProfileMenu, setShowProfileMenu] = useState(false);

  return (
    <header className="sticky top-0 z-20 flex h-[68px] items-center justify-between border-b border-[#E8E5EF] bg-white px-4 sm:px-6">
      {/* Left: Hamburger + Search */}
      <div className="flex flex-1 items-center gap-3 sm:gap-4">
        <button
          type="button"
          onClick={onOpenMobileSidebar}
          className="flex h-10 w-10 items-center justify-center rounded-xl border border-[#E8E5EF] bg-[#F8F8FC] text-[#171322] transition-colors hover:bg-[#F4EAFE] hover:text-[#6A0DAD]"
          aria-label="Toggle navigation menu"
        >
          <HopkidIcon name="menu" className="h-5 w-5" />
        </button>

        <div className="relative w-full max-w-[420px]">
          <HopkidIcon
            name="search"
            className="pointer-events-none absolute top-1/2 left-3.5 h-4 w-4 -translate-y-1/2 text-[#6B7280]"
          />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => onSearchChange(e.target.value)}
            placeholder="Search for orders, products, customers..."
            className="h-10 w-full rounded-xl border border-[#E8E5EF] bg-[#F8F8FC] pr-4 pl-10 text-[13.5px] text-[#171322] placeholder-[#6B7280] transition-all focus:border-[#8B35D1] focus:bg-white focus:ring-2 focus:ring-[#6A0DAD]/15 focus:outline-none"
          />
        </div>
      </div>

      {/* Right: Notification, Help, Admin Profile */}
      <div className="flex items-center gap-2 sm:gap-3.5">
        <div className="relative">
          <button
            type="button"
            onClick={() => {
              setShowNotifications((prev) => !prev);
              setShowProfileMenu(false);
            }}
            className="relative flex h-10 w-10 items-center justify-center rounded-xl border border-[#E8E5EF] bg-white text-[#171322] transition-colors hover:bg-[#F4EAFE] hover:text-[#6A0DAD]"
            aria-label="Notifications"
          >
            <HopkidIcon name="bell" className="h-[18px] w-[18px]" />
            <span className="absolute top-2 right-2.5 h-2 w-2 rounded-full bg-[#EC4899] ring-2 ring-white" />
          </button>

          {showNotifications && (
            <div className="absolute right-0 mt-2 w-72 rounded-2xl border border-[#E8E5EF] bg-white p-3.5 shadow-xl">
              <div className="mb-2 flex items-center justify-between">
                <span className="text-xs font-bold text-[#171322]">Notifications</span>
                <span className="rounded-full bg-[#F4EAFE] px-2 py-0.5 text-[10px] font-semibold text-[#6A0DAD]">
                  3 New
                </span>
              </div>
              <div className="space-y-2 text-xs">
                <div className="rounded-xl bg-[#F8F8FC] p-2.5">
                  <p className="font-semibold text-[#171322]">New Order #HPK2418</p>
                  <p className="text-[#6B7280]">Priya Sharma placed an order for ₹2,499</p>
                </div>
                <div className="rounded-xl bg-[#FFF3DF]/70 p-2.5">
                  <p className="font-semibold text-[#171322]">Low Stock Alert</p>
                  <p className="text-[#6B7280]">Girls Frill Dress has 18 units left</p>
                </div>
              </div>
            </div>
          )}
        </div>

        <button
          type="button"
          onClick={() => navigate('/settings/general')}
          className="hidden sm:flex h-10 w-10 items-center justify-center rounded-xl border border-[#E8E5EF] bg-white text-[#171322] transition-colors hover:bg-[#F4EAFE] hover:text-[#6A0DAD]"
          aria-label="Help center"
          title="Help & Store Settings"
        >
          <HopkidIcon name="help" className="h-[18px] w-[18px]" />
        </button>

        <div className="hidden h-6 w-px bg-[#E8E5EF] sm:block" />

        <div className="relative">
          <button
            type="button"
            onClick={() => {
              setShowProfileMenu((prev) => !prev);
              setShowNotifications(false);
            }}
            className="flex items-center gap-2.5 rounded-xl py-1 pr-1.5 pl-1 transition-colors hover:bg-[#F8F8FC]"
          >
            <div className="flex h-9 w-9 items-center justify-center rounded-full bg-gradient-to-br from-[#6A0DAD] to-[#EC4899] text-xs font-bold text-white shadow-sm ring-2 ring-[#F0E5FC]">
              AV
            </div>
            <div className="hidden text-left md:block">
              <p className="text-[13px] font-semibold text-[#171322] leading-tight">
                Ananya Verma
              </p>
              <p className="text-[11px] font-medium text-[#6B7280] leading-tight">
                Super Admin
              </p>
            </div>
            <HopkidIcon
              name="chevronDown"
              className="hidden h-4 w-4 text-[#6B7280] md:block"
            />
          </button>

          {showProfileMenu && (
            <div className="absolute right-0 mt-2 w-48 rounded-2xl border border-[#E8E5EF] bg-white p-1.5 shadow-xl">
              <button
                type="button"
                onClick={() => {
                  setShowProfileMenu(false);
                  navigate('/users');
                }}
                className="flex w-full items-center gap-2.5 rounded-xl px-3 py-2 text-xs font-medium text-[#171322] hover:bg-[#F4EAFE] hover:text-[#6A0DAD]"
              >
                <HopkidIcon name="user" className="h-4 w-4" />
                Admin Profile
              </button>
              <button
                type="button"
                onClick={() => {
                  setShowProfileMenu(false);
                  navigate('/settings/general');
                }}
                className="flex w-full items-center gap-2.5 rounded-xl px-3 py-2 text-xs font-medium text-[#171322] hover:bg-[#F4EAFE] hover:text-[#6A0DAD]"
              >
                <HopkidIcon name="settings" className="h-4 w-4" />
                Store Settings
              </button>
              <div className="my-1 h-px bg-[#E8E5EF]" />
              <button
                type="button"
                onClick={() => setShowProfileMenu(false)}
                className="flex w-full items-center gap-2.5 rounded-xl px-3 py-2 text-xs font-medium text-rose-600 hover:bg-rose-50"
              >
                <HopkidIcon name="logout" className="h-4 w-4" />
                Sign Out
              </button>
            </div>
          )}
        </div>
      </div>
    </header>
  );
};
