import React, { useEffect, useMemo, useState } from 'react';
import { useOutletContext } from 'react-router-dom';
import { AlertCircle, RefreshCw } from 'lucide-react';
import type { LayoutOutletContext } from '../components/layout/AdminLayout';
import { WelcomeBanner } from '../components/dashboard/WelcomeBanner';
import { KpiCards } from '../components/dashboard/KpiCards';
import { SalesOverviewCard } from '../components/dashboard/SalesOverviewCard';
import { OrderStatusCard } from '../components/dashboard/OrderStatusCard';
import { PromoBannerCard } from '../components/dashboard/PromoBannerCard';
import { QuickActionsCard } from '../components/dashboard/QuickActionsCard';
import { RecentOrdersCard } from '../components/dashboard/RecentOrdersCard';
import { TopProductsCard } from '../components/dashboard/TopProductsCard';
import { TodayGlanceCard } from '../components/dashboard/TodayGlanceCard';
import { InventoryStatusCard } from '../components/dashboard/InventoryStatusCard';
import {
  fetchDashboardData,
  getDemoDashboardData,
} from '../services/dashboardService';
import type { DashboardData, DateRangeKey } from '../types/dashboard';

export const DashboardPage: React.FC = () => {
  const { searchQuery } = useOutletContext<LayoutOutletContext>();
  const [dateRange, setDateRange] = useState<DateRangeKey>('30d');
  const [data, setData] = useState<DashboardData>(() => getDemoDashboardData('30d'));
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);

  const loadData = async (range: DateRangeKey) => {
    setLoading(true);
    setError(null);
    try {
      const result = await fetchDashboardData(range);
      setData(result);
    } catch (err) {
      setError(
        err instanceof Error ? err.message : 'Unable to load dashboard metrics.'
      );
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    void loadData(dateRange);
  }, [dateRange]);

  const normalizedQuery = searchQuery.trim().toLowerCase();

  const filteredOrders = useMemo(() => {
    if (!normalizedQuery) return data.recentOrders;
    return data.recentOrders.filter(
      (order) =>
        order.id.toLowerCase().includes(normalizedQuery) ||
        order.customerName.toLowerCase().includes(normalizedQuery) ||
        order.status.toLowerCase().includes(normalizedQuery)
    );
  }, [data.recentOrders, normalizedQuery]);

  const filteredTopProducts = useMemo(() => {
    if (!normalizedQuery) return data.topProducts;
    return data.topProducts.filter(
      (p) =>
        p.name.toLowerCase().includes(normalizedQuery) ||
        p.variant.toLowerCase().includes(normalizedQuery)
    );
  }, [data.topProducts, normalizedQuery]);

  const filteredInventory = useMemo(() => {
    if (!normalizedQuery) return data.inventory;
    return data.inventory.filter(
      (item) =>
        item.name.toLowerCase().includes(normalizedQuery) ||
        item.sku.toLowerCase().includes(normalizedQuery) ||
        item.status.toLowerCase().includes(normalizedQuery)
    );
  }, [data.inventory, normalizedQuery]);

  return (
    <div className="space-y-5">
      {error && (
        <div className="flex flex-wrap items-center justify-between gap-3 rounded-2xl border border-rose-200 bg-rose-50 px-4 py-3 text-sm text-rose-700">
          <div className="flex items-center gap-2">
            <AlertCircle className="h-4 w-4 shrink-0" />
            <span>{error}</span>
          </div>
          <button
            type="button"
            onClick={() => void loadData(dateRange)}
            className="inline-flex items-center gap-1.5 rounded-xl bg-white px-3 py-1.5 text-xs font-bold text-rose-700 shadow-2xs ring-1 ring-rose-200 hover:bg-rose-100"
          >
            <RefreshCw className="h-3.5 w-3.5" />
            Retry
          </button>
        </div>
      )}

      {/* Welcome Banner */}
      <WelcomeBanner />

      {/* 4 KPI Cards */}
      <KpiCards kpis={data.kpis} loading={loading} />

      {/* Sales Overview (Left ~62%) + Order Status & Promo Banner (Right ~38%) */}
      <div className="grid grid-cols-1 gap-5 xl:grid-cols-12">
        <div className="xl:col-span-7">
          <SalesOverviewCard
            total={data.salesTotal}
            growth={data.salesGrowth}
            comparisonText={data.salesComparisonText}
            data={data.salesSeries}
            dateRange={dateRange}
            onDateRangeChange={setDateRange}
            loading={loading}
          />
        </div>
        <div className="flex flex-col gap-5 xl:col-span-5">
          <OrderStatusCard
            totalOrders={data.totalOrdersCount}
            statuses={data.orderStatuses}
            loading={loading}
          />
          <PromoBannerCard />
        </div>
      </div>

      {/* Quick Actions */}
      <QuickActionsCard />

      {/* Recent Orders + Top Selling Products */}
      <div className="grid grid-cols-1 gap-5 xl:grid-cols-12">
        <div className="xl:col-span-7">
          <RecentOrdersCard orders={filteredOrders} loading={loading} />
        </div>
        <div className="xl:col-span-5">
          <TopProductsCard products={filteredTopProducts} loading={loading} />
        </div>
      </div>

      {/* Today at a Glance + Inventory Status */}
      <div className="grid grid-cols-1 gap-5 xl:grid-cols-12">
        <div className="xl:col-span-5">
          <TodayGlanceCard stats={data.todayStats} loading={loading} />
        </div>
        <div className="xl:col-span-7">
          <InventoryStatusCard items={filteredInventory} loading={loading} />
        </div>
      </div>
    </div>
  );
};
