import React from 'react';
import {
  RiDashboardLine,
  RiDashboardFill,
  RiShoppingBag3Line,
  RiShoppingBag3Fill,
  RiBox3Line,
  RiBox3Fill,
  RiFolder3Line,
  RiFolder3Fill,
  RiAwardLine,
  RiAwardFill,
  RiStore2Line,
  RiStore2Fill,
  RiGroupLine,
  RiGroupFill,
  RiMegaphoneLine,
  RiMegaphoneFill,
  RiCoupon3Line,
  RiCoupon3Fill,
  RiImageLine,
  RiImageFill,
  RiLayout4Line,
  RiLayout4Fill,
  RiBarChartBoxLine,
  RiBarChartBoxFill,
  RiRefund2Line,
  RiRefund2Fill,
  RiShieldUserLine,
  RiShieldUserFill,
  RiSettings3Line,
  RiSettings3Fill,
  RiArrowDownSLine,
  RiArrowRightSLine,
  RiVipCrownLine,
  RiVipCrownFill,
  RiCloseLine,
  RiMenuLine,
  RiSearchLine,
  RiNotification3Line,
  RiQuestionLine,
  RiLogoutBoxRLine,
  RiUserLine,
  RiSparkling2Fill,
  RiShoppingCart2Line,
  RiLineChartLine,
  RiArrowRightLine,
  RiArrowRightUpLine,
  RiTrophyFill,
  RiAddCircleLine,
  RiUploadCloud2Line,
  RiCurrencyLine,
  RiUserAddLine,
  RiRepeatLine,
  RiErrorWarningLine,
  RiRefreshLine,
  RiArrowLeftLine,
  RiTShirt2Line,
  RiHeart3Line,
  RiEmotionHappyLine,
  type RemixiconComponentType,
} from '@remixicon/react';

export type HopkidIconName =
  | 'dashboard'
  | 'orders'
  | 'products'
  | 'categories'
  | 'brands'
  | 'inventory'
  | 'customers'
  | 'marketing'
  | 'discounts'
  | 'banners'
  | 'homepage'
  | 'reports'
  | 'returns'
  | 'users'
  | 'settings'
  | 'chevronDown'
  | 'chevronRight'
  | 'crown'
  | 'close'
  | 'menu'
  | 'search'
  | 'bell'
  | 'help'
  | 'logout'
  | 'user'
  | 'sparkles'
  | 'cart'
  | 'bag'
  | 'package'
  | 'trendingUp'
  | 'arrowRight'
  | 'arrowUpRight'
  | 'arrowLeft'
  | 'trophy'
  | 'plusCircle'
  | 'upload'
  | 'rupee'
  | 'userPlus'
  | 'repeat'
  | 'alert'
  | 'refresh'
  | 'tshirt'
  | 'dress'
  | 'baby';

const LINE_ICONS: Record<HopkidIconName, RemixiconComponentType> = {
  dashboard: RiDashboardLine,
  orders: RiShoppingBag3Line,
  products: RiBox3Line,
  categories: RiFolder3Line,
  brands: RiAwardLine,
  inventory: RiStore2Line,
  customers: RiGroupLine,
  marketing: RiMegaphoneLine,
  discounts: RiCoupon3Line,
  banners: RiImageLine,
  homepage: RiLayout4Line,
  reports: RiBarChartBoxLine,
  returns: RiRefund2Line,
  users: RiShieldUserLine,
  settings: RiSettings3Line,
  chevronDown: RiArrowDownSLine,
  chevronRight: RiArrowRightSLine,
  crown: RiVipCrownLine,
  close: RiCloseLine,
  menu: RiMenuLine,
  search: RiSearchLine,
  bell: RiNotification3Line,
  help: RiQuestionLine,
  logout: RiLogoutBoxRLine,
  user: RiUserLine,
  sparkles: RiSparkling2Fill,
  cart: RiShoppingCart2Line,
  bag: RiShoppingBag3Line,
  package: RiBox3Line,
  trendingUp: RiLineChartLine,
  arrowRight: RiArrowRightLine,
  arrowUpRight: RiArrowRightUpLine,
  arrowLeft: RiArrowLeftLine,
  trophy: RiTrophyFill,
  plusCircle: RiAddCircleLine,
  upload: RiUploadCloud2Line,
  rupee: RiCurrencyLine,
  userPlus: RiUserAddLine,
  repeat: RiRepeatLine,
  alert: RiErrorWarningLine,
  refresh: RiRefreshLine,
  tshirt: RiTShirt2Line,
  dress: RiHeart3Line,
  baby: RiEmotionHappyLine,
};

const FILL_ICONS: Partial<Record<HopkidIconName, RemixiconComponentType>> = {
  dashboard: RiDashboardFill,
  orders: RiShoppingBag3Fill,
  products: RiBox3Fill,
  categories: RiFolder3Fill,
  brands: RiAwardFill,
  inventory: RiStore2Fill,
  customers: RiGroupFill,
  marketing: RiMegaphoneFill,
  discounts: RiCoupon3Fill,
  banners: RiImageFill,
  homepage: RiLayout4Fill,
  reports: RiBarChartBoxFill,
  returns: RiRefund2Fill,
  users: RiShieldUserFill,
  settings: RiSettings3Fill,
  crown: RiVipCrownFill,
};

interface HopkidIconProps {
  name: HopkidIconName;
  active?: boolean;
  className?: string;
  size?: number | string;
}

export const HopkidIcon: React.FC<HopkidIconProps> = ({
  name,
  active = false,
  className,
  size,
}) => {
  const IconComponent =
    (active ? FILL_ICONS[name] : undefined) ?? LINE_ICONS[name];
  return <IconComponent className={className} size={size} aria-hidden="true" />;
};
