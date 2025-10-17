import React, { useState } from 'react';
import { Menu, X, Home, Navigation, BarChart3, Leaf } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import PageTransition from '../components/PageTransition';

const Dashboard: React.FC = () => {
  const [menuOpen, setMenuOpen] = useState(false);
  const [activeNav, setActiveNav] = useState('Home');
  const navigate = useNavigate();

  const toggleMenu = () => {
    setMenuOpen(!menuOpen);
  };

  return (
    <PageTransition>
    <div className="min-h-screen bg-[#EAF8FF] flex flex-col relative">
      {/* Header dengan background hijau */}
      <header className="bg-[#007A3D] rounded-b-[40px] pb-8 relative">
        <div className="px-6 pt-6">
          {/* Top bar dengan logo dan menu */}
          <div className="flex items-center justify-between mb-4">
            {/* Logo dan Teks */}
            <div className="flex items-center gap-3">
              {/* Logo Placeholder */}
              <div className="w-14 h-14 rounded-2xl overflow-hidden bg-white shadow-md flex-shrink-0">
                <img 
                  src="https://public.youware.com/users-website-assets/prod/de0131bc-6b10-4990-9a5c-d971cf8136d2/014fe3b5433b41878d7dc6232d4ba61f.jpg" 
                  alt="MYECO JOURNEY Logo" 
                  className="w-full h-full object-cover"
                />
              </div>
              
              {/* Text */}
              <div className="flex flex-col">
                <h1 className="text-white font-bold text-lg tracking-wide">MYECO JOURNEY</h1>
                <p className="text-white/80 text-xs">Carbon Calculator</p>
              </div>
            </div>

            {/* Menu hamburger */}
            <button 
              onClick={toggleMenu}
              className="text-white p-2"
              aria-label="Menu"
            >
              {menuOpen ? <X size={24} /> : <Menu size={24} />}
            </button>
          </div>

          {/* Kotak sambutan hijau terang */}
          <div className="bg-[#1DC763] rounded-2xl px-5 py-4 mt-4">
            <p className="text-white font-semibold text-center text-sm mb-1">
              Selamat datang, User MYECO JOURNEY!
            </p>
            <p className="text-white text-xs text-center leading-relaxed">
              Mari kelola jejak karbon transportasi Anda untuk lingkungan yang lebih bersih
            </p>
          </div>
        </div>

        {/* Dropdown Menu */}
        {menuOpen && (
          <div className="absolute top-20 right-6 bg-white rounded-lg shadow-lg py-2 w-48 z-50">
            <button className="w-full text-left px-4 py-2 text-gray-800 hover:bg-gray-100 text-sm">
              Profile
            </button>
            <button className="w-full text-left px-4 py-2 text-gray-800 hover:bg-gray-100 text-sm">
              Edit Profile
            </button>
            <button className="w-full text-left px-4 py-2 text-gray-800 hover:bg-gray-100 text-sm">
              Ganti Kata Sandi
            </button>
          </div>
        )}
      </header>

      {/* Konten Utama - Cards */}
      <main className="flex-1 px-6 py-8 space-y-5">
        {/* Card 1 - Total Emisi */}
        <div className="bg-white rounded-2xl p-5 shadow-sm flex items-center gap-4">
          {/* Ikon lingkaran merah */}
          <div className="w-14 h-14 bg-[#FF4E4E] rounded-2xl flex items-center justify-center flex-shrink-0">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M18 8.5C18 6.01472 15.9853 4 13.5 4C11.0147 4 9 6.01472 9 8.5C9 10.9853 11.0147 13 13.5 13H15.5C17.433 13 19 14.567 19 16.5C19 18.433 17.433 20 15.5 20H6C3.79086 20 2 18.2091 2 16V8C2 5.79086 3.79086 4 6 4H8" stroke="white" strokeWidth="2" strokeLinecap="round"/>
              <circle cx="16" cy="8" r="1.5" fill="white"/>
            </svg>
          </div>
          
          {/* Text content */}
          <div className="flex-1">
            <h3 className="text-gray-800 font-semibold text-sm mb-1">Total Emisi</h3>
            <p className="text-gray-900 font-bold text-2xl mb-0.5">0.00 kg</p>
            <p className="text-gray-500 text-xs">
              CO<sub>2</sub> yang dihasilkan
            </p>
          </div>
        </div>

        {/* Card 2 - Total Offset */}
        <div className="bg-white rounded-2xl p-5 shadow-sm flex items-center gap-4">
          {/* Ikon lingkaran hijau */}
          <div className="w-14 h-14 bg-[#2ECC71] rounded-2xl flex items-center justify-center flex-shrink-0">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M12 3C12 3 8 7 8 10C8 12.2091 9.79086 14 12 14C14.2091 14 16 12.2091 16 10C16 7 12 3 12 3Z" stroke="white" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              <path d="M12 14V21M12 21H9M12 21H15" stroke="white" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
            </svg>
          </div>
          
          {/* Text content */}
          <div className="flex-1">
            <h3 className="text-gray-800 font-semibold text-sm mb-1">Total Offset</h3>
            <p className="text-gray-900 font-bold text-2xl mb-0.5">0.00 kg</p>
            <p className="text-gray-500 text-xs">
              CO<sub>2</sub> yang dioffset
            </p>
          </div>
        </div>

        {/* Card 3 - Total Laporan */}
        <div className="bg-white rounded-2xl p-5 shadow-sm flex items-center gap-4">
          {/* Ikon lingkaran biru */}
          <div className="w-14 h-14 bg-[#3498DB] rounded-2xl flex items-center justify-center flex-shrink-0">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <rect x="4" y="14" width="3" height="7" rx="1" stroke="white" strokeWidth="2"/>
              <rect x="10.5" y="9" width="3" height="12" rx="1" stroke="white" strokeWidth="2"/>
              <rect x="17" y="4" width="3" height="17" rx="1" stroke="white" strokeWidth="2"/>
            </svg>
          </div>
          
          {/* Text content */}
          <div className="flex-1">
            <h3 className="text-gray-800 font-semibold text-sm mb-1">Total Laporan</h3>
            <p className="text-gray-900 font-bold text-2xl mb-0.5">1</p>
            <p className="text-gray-500 text-xs">Total Laporan Track</p>
          </div>
        </div>
      </main>

      {/* Bottom Navigation Bar */}
      <nav className="bg-white border-t border-gray-200 py-3 sticky bottom-0">
        <div className="flex items-center justify-around max-w-md mx-auto">
          {/* Home */}
          <button 
            onClick={() => setActiveNav('Home')}
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
            onClick={() => {
              setActiveNav('Tracking');
              navigate('/tracking');
            }}
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

export default Dashboard;
