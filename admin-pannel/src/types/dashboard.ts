import type { HopkidIconName } from '../components/common/HopkidIcon';

export type DateRangeKey = '7d' | '30d' | '90d' | '1y';

export interface KpiMetric {
  id: 'sales' | 'orders' | 'customers' | 'products';
  label: string;
  value: string;
  growth: string;
  isPositive: boolean;
  subtitle: string;
  sparkline: { value: number }[];
}

export interface SalesPoint {
  date: string;
  sales: number;
  orders: number;
}

export interface OrderStatusItem {
  name: 'Delivered' | 'Processing' | 'Shipped' | 'Pending' | 'Cancelled';
  count: number;
  percentage: number;
  color: string;
}

export type StockStatus = 'In Stock' | 'Low Stock' | 'Out of Stock';

export interface InventoryItem {
  id: string;
  name: string;
  sku: string;
  status: StockStatus;
  quantity: number;
  colorSwatch: string;
  iconName: HopkidIconName;
}

export type OrderBadgeStatus = 'Delivered' | 'Shipped' | 'Processing' | 'Pending' | 'Cancelled';

export interface RecentOrder {
  id: string;
  customerName: string;
  customerInitials: string;
  avatarBg: string;
  amount: string;
  status: OrderBadgeStatus;
  date: string;
}

export interface TopProduct {
  id: string;
  rank: number;
  name: string;
  variant: string;
  sold: number;
  price: string;
  bgTint: string;
  iconName: HopkidIconName;
}

export interface TodayStat {
  id: 'orders' | 'sales' | 'new_customers' | 'returning';
  label: string;
  value: string;
  bgClass: string;
  iconBgClass: string;
  iconColorClass: string;
}

export interface DashboardData {
  kpis: KpiMetric[];
  salesTotal: string;
  salesGrowth: string;
  salesComparisonText: string;
  salesSeries: SalesPoint[];
  totalOrdersCount: number;
  orderStatuses: OrderStatusItem[];
  inventory: InventoryItem[];
  recentOrders: RecentOrder[];
  topProducts: TopProduct[];
  todayStats: TodayStat[];
}
