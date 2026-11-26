import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AdminLayout } from './components/layout/AdminLayout';
import { DashboardPage } from './pages/DashboardPage';
import { SectionPage } from './pages/SectionPage';

export function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route element={<AdminLayout />}>
          <Route path="/" element={<DashboardPage />} />
          <Route
            path="/orders"
            element={
              <SectionPage
                title="Orders Management"
                description="Track, fulfill, and manage all Hopkid customer orders."
              />
            }
          />
          <Route
            path="/products"
            element={
              <SectionPage
                title="All Products"
                description="Browse and edit your kids' fashion catalog."
              />
            }
          />
          <Route
            path="/products/new"
            element={
              <SectionPage
                title="Add New Product"
                description="Create a new kids' clothing listing with sizes, colors, and pricing."
              />
            }
          />
          <Route
            path="/products/attributes"
            element={
              <SectionPage
                title="Size & Color Attributes"
                description="Manage age groups, sizes, fabric types, and color swatches."
              />
            }
          />
          <Route
            path="/categories"
            element={
              <SectionPage
                title="Categories"
                description="Organize Boys, Girls, Baby, and Festive collections."
              />
            }
          />
          <Route
            path="/brands"
            element={
              <SectionPage
                title="Brands"
                description="Manage Hopkid in-house lines and partner kids' labels."
              />
            }
          />
          <Route
            path="/inventory"
            element={
              <SectionPage
                title="Inventory Management"
                description="Monitor stock levels, low-stock alerts, and warehouse SKUs."
              />
            }
          />
          <Route
            path="/customers"
            element={
              <SectionPage
                title="Customers"
                description="View customer profiles, order history, and loyalty segments."
              />
            }
          />
          <Route
            path="/marketing/campaigns"
            element={
              <SectionPage
                title="Marketing Campaigns"
                description="Launch seasonal sales and celebration campaigns."
              />
            }
          />
          <Route
            path="/marketing/notifications"
            element={
              <SectionPage
                title="Email & Push Notifications"
                description="Send targeted offers and order updates to parents."
              />
            }
          />
          <Route
            path="/discounts"
            element={
              <SectionPage
                title="Discounts & Coupons"
                description="Create promo codes, festive flat discounts, and BOGO offers."
              />
            }
          />
          <Route
            path="/banners"
            element={
              <SectionPage
                title="Banners & Sliders"
                description="Upload and schedule homepage hero banners and collection promos."
              />
            }
          />
          <Route
            path="/homepage"
            element={
              <SectionPage
                title="Homepage Manager"
                description="Curate featured collections and storefront layout blocks."
              />
            }
          />
          <Route
            path="/reports/sales"
            element={
              <SectionPage
                title="Sales Reports"
                description="Analyze revenue trends, conversion rates, and category performance."
              />
            }
          />
          <Route
            path="/reports/customers"
            element={
              <SectionPage
                title="Customer Insights"
                description="Track retention, repeat buyers, and cohort growth."
              />
            }
          />
          <Route
            path="/returns"
            element={
              <SectionPage
                title="Returns & Refunds"
                description="Review return requests, size exchanges, and refund settlements."
              />
            }
          />
          <Route
            path="/users"
            element={
              <SectionPage
                title="Users & Roles"
                description="Manage admin team members, permissions, and Super Admin access."
              />
            }
          />
          <Route
            path="/settings/general"
            element={
              <SectionPage
                title="Store General Settings"
                description="Configure store details, currency (INR), and support contacts."
              />
            }
          />
          <Route
            path="/settings/payments"
            element={
              <SectionPage
                title="Payments & GST"
                description="Configure UPI, cards, COD, and GST invoicing rules."
              />
            }
          />
          <Route
            path="/settings/shipping"
            element={
              <SectionPage
                title="Shipping Zones"
                description="Set delivery rates, courier partners, and free-shipping thresholds."
              />
            }
          />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
