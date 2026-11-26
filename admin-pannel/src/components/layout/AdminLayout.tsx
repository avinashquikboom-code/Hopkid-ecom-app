import React, { useState } from 'react';
import { Outlet } from 'react-router-dom';
import { Sidebar } from './Sidebar';
import { TopHeader } from './TopHeader';

export interface LayoutOutletContext {
  searchQuery: string;
}

export const AdminLayout: React.FC = () => {
  const [mobileOpen, setMobileOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');

  return (
    <div className="flex min-h-screen bg-[#F8F8FC] text-[#171322]">
      <Sidebar
        mobileOpen={mobileOpen}
        onCloseMobile={() => setMobileOpen(false)}
      />

      <div className="flex min-w-0 flex-1 flex-col">
        <TopHeader
          onOpenMobileSidebar={() => setMobileOpen(true)}
          searchQuery={searchQuery}
          onSearchChange={setSearchQuery}
        />

        <main className="flex-1 p-4 sm:p-6">
          <div className="mx-auto max-w-[1440px]">
            <Outlet context={{ searchQuery } satisfies LayoutOutletContext} />
          </div>
        </main>
      </div>
    </div>
  );
};
