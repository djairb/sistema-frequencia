import { useState, useContext } from 'react';
import { Outlet, Navigate } from 'react-router-dom';
import { AuthContext } from '../contexts/auth';
import { Sidebar } from '../components/Sidebar';
import { Menu } from 'lucide-react'; // Ícone do Hamburguer

export function DefaultLayout() {
  const { signed, loading } = useContext(AuthContext);
  const [isSidebarOpen, setIsSidebarOpen] = useState(false); // Estado para controlar o menu mobile

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-slate-50">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  if (!signed) {
    return <Navigate to="/" />;
  }

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col md:flex-row">
      
      {/* BARRA DE TOPO MOBILE (Só aparece em telas pequenas 'md:hidden') */}
      <div className="bg-slate-900 text-white p-4 flex items-center justify-between md:hidden sticky top-0 z-30 shadow-md">
        <span className="font-bold text-lg">SysConex</span>
        <button 
          onClick={() => setIsSidebarOpen(true)}
          className="p-2 hover:bg-slate-800 rounded-md transition-colors"
        >
          <Menu size={24} />
        </button>
      </div>

      {/* Menu Lateral (Passamos o estado e a função de fechar) */}
      <Sidebar 
        isOpen={isSidebarOpen} 
        onClose={() => setIsSidebarOpen(false)} 
      />

      {/* Área de Conteúdo */}
      {/* No mobile: ml-0 (sem margem). No Desktop (md): ml-64 (margem do menu) */}
      <main className="flex-1 md:ml-64 p-4 md:p-8 overflow-y-auto h-[calc(100vh-64px)] md:h-screen">
        <Outlet />
      </main>
    </div>
  );
}