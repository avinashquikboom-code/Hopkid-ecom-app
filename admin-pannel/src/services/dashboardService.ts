import type { DashboardData, DateRangeKey, SalesPoint } from '../types/dashboard';

const SALES_SERIES_BY_RANGE: Record<
  DateRangeKey,
  { total: string; growth: string; comparison: string; points: SalesPoint[] }
> = {
  '7d': {
    total: '₹3,42,180',
    growth: '+14.2%',
    comparison: 'vs previous 7 days',
    points: [
      { date: 'Nov 16', sales: 38200, orders: 64 },
      { date: 'Nov 17', sales: 44500, orders: 72 },
      { date: 'Nov 18', sales: 41900, orders: 69 },
      { date: 'Nov 19', sales: 51200, orders: 84 },
      { date: 'Nov 20', sales: 49800, orders: 81 },
      { date: 'Nov 21', sales: 56400, orders: 92 },
      { date: 'Nov 22', sales: 60180, orders: 98 },
    ],
  },
  '30d': {
    total: '₹12,84,560',
    growth: '+18.6%',
    comparison: 'vs previous 30 days',
    points: [
      { date: 'Oct 24', sales: 28000, orders: 52 },
      { date: 'Oct 28', sales: 34500, orders: 61 },
      { date: 'Nov 01', sales: 31200, orders: 58 },
      { date: 'Nov 05', sales: 42800, orders: 78 },
      { date: 'Nov 09', sales: 39400, orders: 71 },
      { date: 'Nov 13', sales: 52100, orders: 94 },
      { date: 'Nov 17', sales: 48600, orders: 89 },
      { date: 'Nov 20', sales: 61500, orders: 112 },
      { date: 'Nov 22', sales: 68400, orders: 124 },
    ],
  },
  '90d': {
    total: '₹36,92,410',
    growth: '+22.4%',
    comparison: 'vs previous 90 days',
    points: [
      { date: 'Sep W1', sales: 245000, orders: 430 },
      { date: 'Sep W3', sales: 284000, orders: 495 },
      { date: 'Oct W1', sales: 312000, orders: 540 },
      { date: 'Oct W3', sales: 368000, orders: 642 },
      { date: 'Nov W1', sales: 425000, orders: 745 },
      { date: 'Nov W3', sales: 489000, orders: 860 },
    ],
  },
  '1y': {
    total: '₹1,48,60,900',
    growth: '+29.1%',
    comparison: 'vs previous year',
    points: [
      { date: 'Jan', sales: 820000, orders: 1410 },
      { date: 'Mar', sales: 960000, orders: 1650 },
      { date: 'May', sales: 1120000, orders: 1920 },
      { date: 'Jul', sales: 1240000, orders: 2140 },
      { date: 'Sep', sales: 1380000, orders: 2390 },
      { date: 'Nov', sales: 1580000, orders: 2740 },
    ],
  },
};

export function getDemoDashboardData(range: DateRangeKey = '30d'): DashboardData {
  const salesRange = SALES_SERIES_BY_RANGE[range];

  return {
    kpis: [
      {
        id: 'sales',
        label: 'Total Sales',
        value: '₹12,84,560',
        growth: '+18.6%',
        isPositive: true,
        subtitle: 'vs last 30 days',
        sparkline: [
          { value: 24 },
          { value: 32 },
          { value: 29 },
          { value: 44 },
          { value: 41 },
          { value: 56 },
          { value: 68 },
        ],
      },
      {
        id: 'orders',
        label: 'Total Orders',
        value: '2,418',
        growth: '+12.4%',
        isPositive: true,
        subtitle: 'vs last 30 days',
        sparkline: [
          { value: 18 },
          { value: 22 },
          { value: 27 },
          { value: 25 },
          { value: 34 },
          { value: 39 },
          { value: 46 },
        ],
      },
      {
        id: 'customers',
        label: 'Total Customers',
        value: '8,965',
        growth: '+21.3%',
        isPositive: true,
        subtitle: 'vs last 30 days',
        sparkline: [
          { value: 14 },
          { value: 20 },
          { value: 24 },
          { value: 31 },
          { value: 35 },
          { value: 44 },
          { value: 52 },
        ],
      },
      {
        id: 'products',
        label: 'Total Products',
        value: '1,356',
        growth: '+8.9%',
        isPositive: true,
        subtitle: 'vs last 30 days',
        sparkline: [
          { value: 30 },
          { value: 31 },
          { value: 33 },
          { value: 32 },
          { value: 36 },
          { value: 38 },
          { value: 42 },
        ],
      },
    ],
    salesTotal: salesRange.total,
    salesGrowth: salesRange.growth,
    salesComparisonText: salesRange.comparison,
    salesSeries: salesRange.points,
    totalOrdersCount: 2418,
    orderStatuses: [
      { name: 'Delivered', count: 1642, percentage: 67.9, color: '#6A0DAD' },
      { name: 'Processing', count: 342, percentage: 14.1, color: '#EC4899' },
      { name: 'Shipped', count: 244, percentage: 10.1, color: '#3B82F6' },
      { name: 'Pending', count: 132, percentage: 5.5, color: '#22C55E' },
      { name: 'Cancelled', count: 58, percentage: 2.4, color: '#C084FC' },
    ],
    inventory: [
      {
        id: 'inv-1',
        name: 'Boys Dino Print T-Shirt',
        sku: 'HK-BTS-102',
        status: 'In Stock',
        quantity: 124,
        colorSwatch: 'bg-[#E7F8EA]',
        iconName: 'tshirt',
      },
      {
        id: 'inv-2',
        name: 'Girls Frill Dress',
        sku: 'HK-GFD-098',
        status: 'Low Stock',
        quantity: 18,
        colorSwatch: 'bg-[#FCE7F3]',
        iconName: 'dress',
      },
      {
        id: 'inv-3',
        name: 'Baby Romper Set',
        sku: 'HK-BRS-076',
        status: 'Out of Stock',
        quantity: 0,
        colorSwatch: 'bg-[#FFF3DF]',
        iconName: 'baby',
      },
    ],
    recentOrders: [
      {
        id: '#HPK2418',
        customerName: 'Priya Sharma',
        customerInitials: 'PS',
        avatarBg: 'bg-[#F0E5FC] text-[#6A0DAD]',
        amount: '₹2,499',
        status: 'Delivered',
        date: 'Nov 22, 2026',
      },
      {
        id: '#HPK2417',
        customerName: 'Rohan Mehta',
        customerInitials: 'RM',
        avatarBg: 'bg-[#E8F2FF] text-[#2563EB]',
        amount: '₹1,299',
        status: 'Shipped',
        date: 'Nov 22, 2026',
      },
      {
        id: '#HPK2416',
        customerName: 'Neha Patel',
        customerInitials: 'NP',
        avatarBg: 'bg-[#FCE7F3] text-[#DB2777]',
        amount: '₹3,499',
        status: 'Processing',
        date: 'Nov 21, 2026',
      },
      {
        id: '#HPK2415',
        customerName: 'Amit Desai',
        customerInitials: 'AD',
        avatarBg: 'bg-[#E7F8EA] text-[#16A34A]',
        amount: '₹1,899',
        status: 'Delivered',
        date: 'Nov 21, 2026',
      },
    ],
    topProducts: [
      {
        id: 'tp-1',
        rank: 1,
        name: 'Boys Hoodie Sweatshirt',
        variant: 'Purple',
        sold: 652,
        price: '₹799',
        bgTint: 'bg-[#F0E5FC]',
        iconName: 'tshirt',
      },
      {
        id: 'tp-2',
        rank: 2,
        name: 'Girls Frill Dress',
        variant: 'Pink',
        sold: 489,
        price: '₹899',
        bgTint: 'bg-[#FCE7F3]',
        iconName: 'dress',
      },
      {
        id: 'tp-3',
        rank: 3,
        name: 'Baby Romper Set',
        variant: 'Beige',
        sold: 418,
        price: '₹639',
        bgTint: 'bg-[#FFF3DF]',
        iconName: 'baby',
      },
    ],
    todayStats: [
      {
        id: 'orders',
        label: 'Orders',
        value: '86',
        bgClass: 'bg-[#F4EAFE]',
        iconBgClass: 'bg-white',
        iconColorClass: 'text-[#6A0DAD]',
      },
      {
        id: 'sales',
        label: 'Sales',
        value: '₹48,320',
        bgClass: 'bg-[#FCE7F3]',
        iconBgClass: 'bg-white',
        iconColorClass: 'text-[#DB2777]',
      },
      {
        id: 'new_customers',
        label: 'New Customers',
        value: '37',
        bgClass: 'bg-[#E8F2FF]',
        iconBgClass: 'bg-white',
        iconColorClass: 'text-[#2563EB]',
      },
      {
        id: 'returning',
        label: 'Returning',
        value: '24',
        bgClass: 'bg-[#E7F8EA]',
        iconBgClass: 'bg-white',
        iconColorClass: 'text-[#16A34A]',
      },
    ],
  };
}

/**
 * Fetches dashboard metrics from the configured backend API if VITE_API_URL is set,
 * otherwise returns the isolated Hopkid demo dataset after a short simulated delay.
 */
export async function fetchDashboardData(range: DateRangeKey = '30d'): Promise<DashboardData> {
  const apiUrl = import.meta.env.VITE_API_URL as string | undefined;

  if (apiUrl) {
    const response = await fetch(`${apiUrl}/admin/dashboard?range=${range}`);
    if (!response.ok) {
      throw new Error(`Dashboard API returned ${response.status}`);
    }
    return (await response.json()) as DashboardData;
  }

  // Isolated fallback/demo data
  return new Promise((resolve) => {
    setTimeout(() => resolve(getDemoDashboardData(range)), 180);
  });
}
