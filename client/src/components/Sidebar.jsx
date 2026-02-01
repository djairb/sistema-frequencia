import { useContext } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { AuthContext } from '../contexts/auth';
import { 
  LayoutDashboard, Users, BookOpen, CalendarCheck, LogOut, X 
} from 'lucide-react';
import clsx from 'clsx';

export function Sidebar({ isOpen, onClose }) {
  // CORREÇÃO 1: O nome da função no contexto é 'logout', não 'signOut'
  const { user, logout } = useContext(AuthContext); 
  const location = useLocation();

  const menus = {
    2: [ // Coordenador
      { label: 'Visão Geral', path: '/app/gestao-turmas', icon: LayoutDashboard },
      { label: 'Turmas & Projetos', path: '/app/turmas', icon: BookOpen },
      { label: 'Professores', path: '/app/professores', icon: Users },
    ],
    6: [ // Professor
      { label: 'Meu Diário', path: '/app/meu-diario', icon: CalendarCheck },
      { label: 'Minhas Turmas', path: '/app/minhas-turmas', icon: BookOpen },
    ]
  };

  // CORREÇÃO 2: O login devolve 'perfil_id', não 'perfil.id'
  // Usamos user?.perfil_id para decidir qual menu mostrar
  const userProfileId = user?.perfil_id;
  const currentMenu = userProfileId ? (menus[userProfileId] || []) : [];

  return (
    <>
      {/* OVERLAY */}
      <div 
        className={clsx(
          "fixed inset-0 bg-black/50 z-40 md:hidden transition-opacity",
          isOpen ? "opacity-100 visible" : "opacity-0 invisible pointer-events-none"
        )}
        onClick={onClose}
      />

      {/* ASIDE */}
      <aside 
        className={clsx(
          "fixed left-0 top-0 bottom-0 z-50 w-64 bg-slate-900 text-white border-r border-slate-800 flex flex-col transition-transform duration-300 ease-in-out",
          isOpen ? "translate-x-0" : "-translate-x-full md:translate-x-0"
        )}
      >
        {/* Header */}
        <div className="h-16 flex items-center justify-between px-6 border-b border-slate-800">
          <span className="text-xl font-bold bg-gradient-to-r from-blue-400 to-indigo-400 bg-clip-text text-transparent">
            SysConex
          </span>
          <button onClick={onClose} className="md:hidden text-gray-400 hover:text-white">
            <X size={24} />
          </button>
        </div>

        {/* Info Usuário */}
        <div className="p-6 border-b border-slate-800 bg-slate-800/50">
          <p className="text-sm text-gray-400">Bem-vindo(a),</p>
          <p className="font-semibold truncate text-white">
              {user?.nome?.split(' ')[0] || "Usuário"}
          </p>
          <p className="text-xs text-blue-400 mt-1 uppercase tracking-wider font-bold">
            {user?.perfil || "Visitante"}
          </p>
        </div>

        {/* Menu Dinâmico */}
        <nav className="flex-1 py-6 px-3 space-y-1 overflow-y-auto">
          {currentMenu.map((item) => {
            const Icon = item.icon;
            const isActive = location.pathname === item.path;
            return (
              <Link
                key={item.path}
                to={item.path}
                onClick={onClose}
                className={clsx(
                  "flex items-center gap-3 px-3 py-3 rounded-lg transition-all text-sm font-medium",
                  isActive 
                    ? "bg-blue-600 text-white shadow-lg shadow-blue-900/20" 
                    : "text-gray-400 hover:bg-slate-800 hover:text-white"
                )}
              >
                <Icon size={20} />
                {item.label}
              </Link>
            );
          })}
        </nav>

        {/* Botão Sair (Agora chama logout) */}
        <div className="p-4 border-t border-slate-800">
          <button 
            onClick={logout} 
            className="flex items-center gap-3 w-full px-3 py-3 text-red-400 hover:bg-red-500/10 hover:text-red-300 rounded-lg transition-colors text-sm font-medium"
          >
            <LogOut size={20} />
            Sair
          </button>
        </div>
      </aside>
    </>
  );
}