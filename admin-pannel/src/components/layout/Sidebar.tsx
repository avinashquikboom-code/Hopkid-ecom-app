import React, { useState } from 'react';
import { NavLink, useLocation } from 'react-router-dom';
import { HopkidIcon, type HopkidIconName } from '../common/HopkidIcon';

interface NavSubItem {
  label: string;
  to: string;
}

interface NavItem {
  id: string;
  label: string;
  iconName: HopkidIconName;
  to?: string;
  badge?: string;
  children?: NavSubItem[];
}

const NAV_ITEMS: NavItem[] = [
  { id: 'dashboard', label: 'Dashboard', iconName: 'dashboard', to: '/' },
  { id: 'orders', label: 'Orders', iconName: 'orders', to: '/orders', badge: '12' },
  {
    id: 'products',
    label: 'Products',
    iconName: 'products',
    children: [
      { label: 'All Products', to: '/products' },
      { label: 'Add Product', to: '/products/new' },
      { label: 'Size & Color Attributes', to: '/products/attributes' },
    ],
  },
  { id: 'categories', label: 'Categories', iconName: 'categories', to: '/categories' },
  { id: 'brands', label: 'Brands', iconName: 'brands', to: '/brands' },
  { id: 'inventory', label: 'Inventory', iconName: 'inventory', to: '/inventory' },
  { id: 'customers', label: 'Customers', iconName: 'customers', to: '/customers' },
  {
    id: 'marketing',
    label: 'Marketing',
    iconName: 'marketing',
    children: [
      { label: 'Campaigns', to: '/marketing/campaigns' },
      { label: 'Email & Push', to: '/marketing/notifications' },
    ],
  },
  { id: 'discounts', label: 'Discounts & Coupons', iconName: 'discounts', to: '/discounts' },
  { id: 'banners', label: 'Banners & Sliders', iconName: 'banners', to: '/banners' },
  { id: 'homepage', label: 'Homepage Manager', iconName: 'homepage', to: '/homepage' },
  {
    id: 'reports',
    label: 'Reports & Analytics',
    iconName: 'reports',
    children: [
      { label: 'Sales Reports', to: '/reports/sales' },
      { label: 'Customer Insights', to: '/reports/customers' },
    ],
  },
  { id: 'returns', label: 'Returns & Refunds', iconName: 'returns', to: '/returns' },
  { id: 'users', label: 'Users & Roles', iconName: 'users', to: '/users' },
  {
    id: 'settings',
    label: 'Settings',
    iconName: 'settings',
    children: [
      { label: 'Store General', to: '/settings/general' },
      { label: 'Payments & GST', to: '/settings/payments' },
      { label: 'Shipping Zones', to: '/settings/shipping' },
    ],
  },
];

interface SidebarProps {
  mobileOpen: boolean;
  onCloseMobile: () => void;
}

export const Sidebar: React.FC<SidebarProps> = ({ mobileOpen, onCloseMobile }) => {
  const location = useLocation();
  const [expanded, setExpanded] = useState<Record<string, boolean>>({
    products: false,
    marketing: false,
    reports: false,
    settings: false,
  });

  const toggleGroup = (id: string) => {
    setExpanded((prev) => ({ ...prev, [id]: !prev[id] }));
  };

  const isGroupActive = (item: NavItem) =>
    item.children?.some((child) => location.pathname === child.to) ?? false;

  const sidebarContent = (
    <aside
      className="flex h-full w-[250px] shrink-0 flex-col justify-between text-white select-none"
      style={{
        background: 'linear-gradient(180deg, #6A0DAD 0%, #4B087E 100%)',
      }}
    >
      {/* Top Brand Logo */}
      <div className="flex items-center justify-between px-5 pt-5 pb-4">
        <NavLink
          to="/"
          onClick={onCloseMobile}
          className="flex items-center gap-2.5 group"
        >
          <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-white/15 backdrop-blur-sm ring-1 ring-white/25 shadow-sm transition-transform group-hover:scale-105">
            <HopkidIcon name="crown" active className="h-5 w-5 text-[#FDE047]" />
          </div>
          <div className="flex flex-col leading-tight">
            <span className="text-[20px] font-extrabold tracking-tight text-white">
              Hop<span className="text-[#FDE047]">kid</span>
            </span>
            <span className="text-[10px] font-medium uppercase tracking-widest text-purple-200/80">
              Kids Fashion Admin
            </span>
          </div>
        </NavLink>

        <button
          type="button"
          onClick={onCloseMobile}
          className="rounded-lg p-1.5 text-white/80 hover:bg-white/10 lg:hidden"
          aria-label="Close sidebar"
        >
          <HopkidIcon name="close" className="h-5 w-5" />
        </button>
      </div>

      {/* Navigation Links */}
      <nav className="sidebar-scroll flex-1 overflow-y-auto px-3 py-1 space-y-0.5">
        {NAV_ITEMS.map((item) => {
          const hasChildren = Boolean(item.children?.length);
          const groupActive = isGroupActive(item);
          const isOpen = expanded[item.id] || groupActive;

          if (hasChildren && item.children) {
            return (
              <div key={item.id} className="space-y-0.5">
                <button
                  type="button"
                  onClick={() => toggleGroup(item.id)}
                  className={`flex w-full items-center justify-between rounded-xl px-3.5 py-2.5 text-[13.5px] font-medium transition-all ${
                    groupActive
                      ? 'bg-white/15 text-white'
                      : 'text-white/90 hover:bg-white/10 hover:text-white'
                  }`}
                >
                  <span className="flex items-center gap-3">
                    <HopkidIcon
                      name={item.iconName}
                      active={groupActive}
                      className="h-[18px] w-[18px] shrink-0 text-white"
                    />
                    <span>{item.label}</span>
                  </span>
                  <HopkidIcon
                    name={isOpen ? 'chevronDown' : 'chevronRight'}
                    className="h-4 w-4 text-white/75"
                  />
                </button>

                {isOpen && (
                  <div className="ml-7 space-y-0.5 border-l border-white/20 pl-3 py-0.5">
                    {item.children.map((sub) => (
                      <NavLink
                        key={sub.to}
                        to={sub.to}
                        onClick={onCloseMobile}
                        className={({ isActive }) =>
                          `block rounded-lg px-3 py-1.5 text-[12.5px] transition-all ${
                            isActive
                              ? 'bg-white text-[#6A0DAD] font-semibold shadow-sm'
                              : 'text-purple-100/85 hover:bg-white/10 hover:text-white'
                          }`
                        }
                      >
                        {sub.label}
                      </NavLink>
                    ))}
                  </div>
                )}
              </div>
            );
          }

          return (
            <NavLink
              key={item.id}
              to={item.to || '/'}
              end={item.to === '/'}
              onClick={onCloseMobile}
              className={({ isActive }) =>
                `flex items-center justify-between rounded-xl px-3.5 py-2.5 text-[13.5px] transition-all ${
                  isActive
                    ? 'bg-white text-[#6A0DAD] font-semibold shadow-md'
                    : 'text-white/90 font-medium hover:bg-white/10 hover:text-white'
                }`
              }
            >
              {({ isActive }) => (
                <>
                  <span className="flex items-center gap-3">
                    <HopkidIcon
                      name={item.iconName}
                      active={isActive}
                      className={`h-[18px] w-[18px] shrink-0 ${
                        isActive ? 'text-[#6A0DAD]' : 'text-white'
                      }`}
                    />
                    <span>{item.label}</span>
                  </span>
                  {item.badge && (
                    <span
                      className={`rounded-full px-2 py-0.5 text-[11px] font-bold leading-none ${
                        isActive
                          ? 'bg-[#F0E5FC] text-[#6A0DAD]'
                          : 'bg-[#F472B6] text-white'
                      }`}
                    >
                      {item.badge}
                    </span>
                  )}
                </>
              )}
            </NavLink>
          );
        })}
      </nav>

      {/* Bottom Decorative Child & Crown Illustration */}
      <div className="px-4 pt-3 pb-4">
        <div className="relative overflow-hidden rounded-2xl bg-white/10 p-3.5 ring-1 ring-white/15 backdrop-blur-sm">
          <span className="absolute top-2 right-3 h-2 w-2 rounded-full bg-[#FDE047]/80" />
          <span className="absolute top-6 right-7 h-1.5 w-1.5 rounded-full bg-pink-300/80" />
          <div className="flex items-center gap-3">
            <svg
              viewBox="0 0 64 64"
              className="h-12 w-12 shrink-0"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
              aria-hidden="true"
            >
              <circle cx="32" cy="36" r="22" fill="#8B35D1" opacity="0.55" />
              <path
                d="M21 20L24 11L32 16L40 11L43 20H21Z"
                fill="#FDE047"
                stroke="#F59E0B"
                strokeWidth="1.5"
                strokeLinejoin="round"
              />
              <circle cx="32" cy="34" r="13" fill="#FDE6D8" />
              <path
                d="M19 32C19 24.8 24.8 20 32 20C39.2 20 45 24.8 45 32C42 28 38 26 32 26C26 26 22 28 19 32Z"
                fill="#4B087E"
              />
              <circle cx="27.5" cy="34" r="1.6" fill="#171322" />
              <circle cx="36.5" cy="34" r="1.6" fill="#171322" />
              <circle cx="24.5" cy="37" r="2" fill="#FDA4AF" opacity="0.7" />
              <circle cx="39.5" cy="37" r="2" fill="#FDA4AF" opacity="0.7" />
              <path
                d="M28 38.5C29.3 40.2 34.7 40.2 36 38.5"
                stroke="#171322"
                strokeWidth="1.6"
                strokeLinecap="round"
              />
              <path
                d="M20 55C20 48.5 25.4 45 32 45C38.6 45 44 48.5 44 55"
                fill="#F472B6"
              />
            </svg>
            <div className="min-w-0">
              <p className="text-xs font-bold text-white leading-snug">
                Festive Season Live!
              </p>
              <p className="mt-0.5 text-[11px] text-purple-100/80 leading-tight">
                Kids Celebration Collection
              </p>
            </div>
          </div>
        </div>
      </div>
    </aside>
  );

  return (
    <>
      <div className="hidden lg:block lg:w-[250px] lg:shrink-0">
        <div className="fixed inset-y-0 left-0 z-30 w-[250px] shadow-xl">
          {sidebarContent}
        </div>
      </div>

      {mobileOpen && (
        <div className="fixed inset-0 z-50 flex lg:hidden">
          <div
            className="fixed inset-0 bg-[#171322]/45 backdrop-blur-[2px]"
            onClick={onCloseMobile}
          />
          <div className="relative z-10 h-full shadow-2xl">{sidebarContent}</div>
        </div>
      )}
    </>
  );
};
