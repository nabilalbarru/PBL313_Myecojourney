import React, { useState } from 'react';
import { ArrowLeft, Menu, X, Home, Navigation, BarChart3, Leaf, Play, MapPin } from 'lucide-react';
import { useNavigate, useParams } from 'react-router-dom';
import { TransportData, transportationData } from '../types/transport';
import PageTransition from '../components/PageTransition';

const GPSTrackingDetail: React.FC = () => {
  const [menuOpen, setMenuOpen] = useState(false);
  const [activeNav, setActiveNav] = useState('Tracking');
  const [isTracking, setIsTracking] = useState(false);
  const navigate = useNavigate();
  const { transportId } = useParams<{ transportId: string }>();
  
  // Cari data transport berdasarkan ID dari URL parameter
  const transport: TransportData = transportationData.find(
    t => t.id === Number(transportId)
  ) || transportationData[0];

  const toggleMenu = () => {
    setMenuOpen(!menuOpen);
  };

  const handleStartTracking = () => {
    // Navigate ke halaman tracking aktif
    navigate(`/tracking/${transportId}/active`);
  };

  return (
    <PageTransition>
    <div className="min-h-screen bg-[#EAF6FF] flex flex-col relative">
      {/* Header dengan background hijau */}
      <header className="bg-[#008000] rounded-b-[40px] pb-6 relative">
        <div className="px-6 pt-6">
          {/* Top bar dengan back button, judul, dan menu */}
          <div className="flex items-center justify-between">
            {/* Back Button */}
            <button 
              onClick={() => navigate(-1)}
              className="text-white p-2"
              aria-label="Kembali"
            >
              <ArrowLeft size={24} />
            </button>

            {/* Title */}
            <h1 className="text-white font-bold text-lg tracking-wide">GPS Tracking</h1>

            {/* Menu hamburger */}
            <button 
              onClick={toggleMenu}
              className="text-white p-2"
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
      <main className="flex-1 px-6 py-6 space-y-5">
        {/* Judul dan Deskripsi */}
        <div>
          <h2 className="text-black font-bold text-lg mb-2">
            Lacak Perjalanan
          </h2>
          <p className="text-gray-500 text-sm">
            Mulai tracking perjalanan Anda untuk menghitung emisi karbon
          </p>
        </div>

        {/* Card Informasi Kendaraan */}
        <div className="bg-white rounded-2xl shadow-md p-5 flex items-center gap-4">
          {/* Ikon Kendaraan */}
          <div className="text-4xl">
            {transport.icon}
          </div>
          
          {/* Informasi */}
          <div>
            <p className="text-black font-bold text-base mb-1">{transport.name}</p>
            {transport.emission && (
              <p className="text-gray-500 text-xs">Emisi: {transport.emission}</p>
            )}
            {!transport.emission && transport.subtitle && (
              <p className="text-gray-500 text-xs">{transport.subtitle}</p>
            )}
          </div>
        </div>

        {/* Card Siap Memulai Perjalanan */}
        <div className="bg-white rounded-2xl shadow-md p-6">
          {/* Judul */}
          <h3 className="text-black font-bold text-base text-center mb-3">
            Siap Memulai Perjalanan
          </h3>

          {/* Badge Status */}
          <div className="flex justify-center mb-5">
            <span className="bg-gray-200 text-gray-700 text-xs font-medium px-4 py-1 rounded-full">
              Standby
            </span>
          </div>

          {/* Tombol Play Besar */}
          <div className="flex justify-center mb-4">
            <button
              onClick={handleStartTracking}
              className="w-24 h-24 bg-black rounded-full flex items-center justify-center shadow-lg hover:bg-gray-800 transition-colors"
              aria-label="Mulai Tracking"
            >
              <Play size={36} className="text-white ml-1" fill="white" />
            </button>
          </div>

          {/* Teks Instruksi */}
          <p className="text-gray-500 text-xs text-center">
            Tekan untuk memulai tracking
          </p>
        </div>

        {/* Card Peta Perjalanan */}
        <div className="bg-white rounded-2xl shadow-md p-5">
          {/* Judul */}
          <h3 className="text-black font-bold text-base mb-4">
            Peta Perjalanan
          </h3>

          {/* Area Peta */}
          <div className="relative w-full h-48 rounded-xl overflow-hidden bg-gradient-to-br from-green-100 via-blue-100 to-blue-200">
            {/* Placeholder Peta */}
            <div className="absolute inset-0 flex flex-col items-center justify-center">
              <MapPin size={32} className="text-gray-400 mb-2" />
              <p className="text-gray-400 text-xs text-center px-4">
                Peta akan aktif saat tracking dimulai
              </p>
            </div>
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
              className={activeNav === 'Home' ? 'text-[#008000]' : 'text-[#8C8C8C]'}
              strokeWidth={activeNav === 'Home' ? 2.5 : 2}
            />
            <span className={`text-xs ${activeNav === 'Home' ? 'text-[#008000] font-medium' : 'text-[#8C8C8C]'}`}>
              Home
            </span>
          </button>

          {/* Tracking */}
          <button 
            onClick={() => {
              setActiveNav('Tracking');
              navigate('/tracking');
            }}
            className="flex flex-col items-center gap-1 min-w-[60px]"
          >
            <Navigation 
              size={22} 
              className={activeNav === 'Tracking' ? 'text-[#008000]' : 'text-[#8C8C8C]'}
              strokeWidth={activeNav === 'Tracking' ? 2.5 : 2}
            />
            <span className={`text-xs ${activeNav === 'Tracking' ? 'text-[#008000] font-medium' : 'text-[#8C8C8C]'}`}>
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
              className={activeNav === 'Monitor' ? 'text-[#008000]' : 'text-[#8C8C8C]'}
              strokeWidth={activeNav === 'Monitor' ? 2.5 : 2}
            />
            <span className={`text-xs ${activeNav === 'Monitor' ? 'text-[#008000] font-medium' : 'text-[#8C8C8C]'}`}>
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
              className={activeNav === 'Offset' ? 'text-[#008000]' : 'text-[#8C8C8C]'}
              strokeWidth={activeNav === 'Offset' ? 2.5 : 2}
            />
            <span className={`text-xs ${activeNav === 'Offset' ? 'text-[#008000] font-medium' : 'text-[#8C8C8C]'}`}>
              Offset
            </span>
          </button>
        </div>
      </nav>
    </div>
    </PageTransition>
  );
};

export default GPSTrackingDetail;
