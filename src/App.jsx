export default function App() {
  return (
    // Fundo escuro que ocupa a tela toda (min-h-screen) e centraliza tudo (flex justify-center items-center)
    <div className="min-h-screen bg-slate-900 flex items-center justify-center p-4">
      
      {/* O Card Branco com sombra */}
      <div className="bg-white p-8 rounded-2xl shadow-2xl max-w-md w-full text-center border-4 border-blue-500/30">
        
        <h1 className="text-4xl font-extrabold text-blue-600 mb-4">
          Tailwind tá ON! 🚀
        </h1>
        
        <p className="text-gray-600 text-lg mb-8 leading-relaxed">
          Se você está vendo este card branco centralizado num fundo escuro, 
          com esse botão bonitão abaixo, a configuração foi um sucesso.
        </p>

        <button className="bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white font-bold py-3 px-8 rounded-full shadow-lg transform transition hover:scale-105 duration-300">
          Partiu Sistema de Frequência!
        </button>
        
      </div>
    </div>
  )
}