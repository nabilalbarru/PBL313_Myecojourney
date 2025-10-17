import React, { useState } from 'react';
import { Menu, X, Home, Navigation, BarChart3, Leaf } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { transportationData, TransportData } from '../types/transport';
import PageTransition from '../components/PageTransition';

const GPSTracking: React.FC = () => {
  const [menuOpen, setMenuOpen] = useState(false);
  const [activeNav, setActiveNav] = useState('Tracking');
  const navigate = useNavigate();

  const toggleMenu = () => {
    setMenuOpen(!menuOpen);
  };

  const handleTransportClick = (transport: TransportData) => {
    console.log(`Selected: ${transport.name}`);
    // Navigasi ke halaman detail tracking dengan state
    navigate(`/tracking/${transport.id}`, { state: { transport } });
  };

  return (
    <PageTransition>
    <div className="min-h-screen bg-[#EAF8FF] flex flex-col relative">
      {/* Header dengan background hijau tua */}
      <header className="bg-[#007A3D] rounded-b-[40px] pb-6 relative">
        <div className="px-6 pt-6">
          {/* Top bar dengan judul dan menu */}
          <div className="flex items-center justify-between">
            {/* Title */}
            <div className="flex-1 text-center">
              <h1 className="text-white font-bold text-lg tracking-wide">GPS TRACKING</h1>
            </div>

            {/* Menu hamburger */}
            <button 
              onClick={toggleMenu}
              className="text-white p-2 absolute right-4 top-6"
              aria-label="Menu"
            >
              {menuOpen ? <X size={24} /> : <Menu size={24} />}
            </button>
          </div>
        </div>

        {/* Dropdown Menu */}
        {menuOpen && (
          <div className="absolute top-20 right-6 bg-white rounded-lg shadow-lg py-2 w-48 z-50">
            <button className="w-full text-left px-4 py-2 text-black hover:bg-[#F0F0F0] text-sm font-normal">
              Profil
            </button>
            <button className="w-full text-left px-4 py-2 text-black hover:bg-[#F0F0F0] text-sm font-normal">
              Edit Profil
            </button>
            <button className="w-full text-left px-4 py-2 text-black hover:bg-[#F0F0F0] text-sm font-normal">
              Ganti Kata Sandi
            </button>
          </div>
        )}
      </header>

      {/* Konten Utama */}
      <main className="flex-1 px-6 py-6">
        {/* Judul Section */}
        <h2 className="text-black font-bold text-base text-center mb-4">
          Pilih Mode Transportasi
        </h2>

        {/* Card Putih dengan Grid Transportasi */}
        <div className="bg-white rounded-xl shadow-md p-4">
          {/* Grid 3 kolom */}
          <div className="grid grid-cols-3 gap-4">
            {transportationData.map((transport) => (
              <button
                key={transport.id}
                onClick={() => handleTransportClick(transport)}
                className="bg-white rounded-md shadow-sm p-2.5 flex flex-col items-center justify-center text-center active:bg-[#F5F5F5] transition-colors min-h-[140px]"
              >
                {/* Ikon */}
                <div className={`text-3xl mb-2 ${transport.iconColor}`}>
                  {transport.icon}
                </div>

                {/* Nama Transportasi */}
                <p className="text-black font-semibold text-xs mb-1">
                  {transport.name}
                </p>

                {/* Subtitle (cc atau ramah lingkungan) */}
                {transport.subtitle && (
                  <p className="text-gray-600 text-[10px] mb-1">
                    {transport.subtitle}
                  </p>
                )}

                {/* Emisi */}
                {transport.emission && (
                  <p className="text-gray-600 text-[10px] mb-2">
                    {transport.emission}
                  </p>
                )}

                {/* Label Emisi */}
                <span className={`${transport.labelColor} text-black text-[9px] font-medium px-2 py-0.5 rounded-full`}>
                  {transport.labelText}
                </span>
              </button>
            ))}
          </div>
        </div>
      </main>

      {/* Bottom Navigation Bar */}
      <nav className="bg-white border-t border-gray-200 py-3 sticky bottom-0">
        <div className="flex items-center justify-around max-w-md mx-auto">
          {/* Home */}
          <button 
            onClick={() => {
              setActiveNav('Home');
              navigate('/');
            }}
            className="flex flex-col items-center gap-1 min-w-[60px]"
          >
            <Home 
              size={22} 
              className={activeNav === 'Home' ? 'text-[#007A3D]' : 'text-[#6E6E6E]'}
              strokeWidth={activeNav === 'Home' ? 2.5 : 2}
            />
            <span className={`text-xs ${activeNav === 'Home' ? 'text-[#007A3D] font-semibold' : 'text-[#6E6E6E]'}`}>
              Home
            </span>
          </button>

          {/* Tracking */}
          <button 
            onClick={() => setActiveNav('Tracking')}
            className="flex flex-col items-center gap-1 min-w-[60px]"
          >
            <Navigation 
              size={22} 
              className={activeNav === 'Tracking' ? 'text-[#007A3D]' : 'text-[#6E6E6E]'}
              strokeWidth={activeNav === 'Tracking' ? 2.5 : 2}
            />
            <span className={`text-xs ${activeNav === 'Tracking' ? 'text-[#007A3D] font-semibold' : 'text-[#6E6E6E]'}`}>
              Tracking
            </span>
          </button>

          {/* Monitor */}
          <button 
            onClick={() => setActiveNav('Monitor')}
            className="flex flex-col items-center gap-1 min-w-[60px]"
          >
            <BarChart3 
              size={22} 
              className={activeNav === 'Monitor' ? 'text-[#007A3D]' : 'text-[#6E6E6E]'}
              strokeWidth={activeNav === 'Monitor' ? 2.5 : 2}
            />
            <span className={`text-xs ${activeNav === 'Monitor' ? 'text-[#007A3D] font-semibold' : 'text-[#6E6E6E]'}`}>
              Monitor
            </span>
          </button>

          {/* Offset */}
          <button 
            onClick={() => setActiveNav('Offset')}
            className="flex flex-col items-center gap-1 min-w-[60px]"
          >
            <Leaf 
              size={22} 
              className={activeNav === 'Offset' ? 'text-[#007A3D]' : 'text-[#6E6E6E]'}
              strokeWidth={activeNav === 'Offset' ? 2.5 : 2}
            />
            <span className={`text-xs ${activeNav === 'Offset' ? 'text-[#007A3D] font-semibold' : 'text-[#6E6E6E]'}`}>
              Offset
            </span>
          </button>
        </div>
      </nav>
    </div>
    </PageTransition>
  );
};

export default GPSTracking;
