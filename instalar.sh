#!/data/data/com.termux/files/usr/bin/bash

# Para o script se houver erro e ignora avisos de bateria
set -e

echo "--- 🚀 INICIANDO INSTALAÇÃO COMPLETA (GABRIEL-TERMUX) ---"

# 1. Atualização Geral
echo "Atualizando repositórios..."
pkg update -y && pkg upgrade -y

# 2. Base de Compilação e Python
echo "Instalando Python e Compiladores..."
TOOLS=("python" "python-pip" "clang" "make" "binutils" "git" "cmake")
for tool in "${TOOLS[@]}"; do
    pkg install "$tool" -y
done

# Criar atalho do GCC apontando para o Clang
ln -sf $PREFIX/bin/clang $PREFIX/bin/gcc

# 3. Pacotes de Interface Gráfica (X11)
echo "Instalando suporte a X11 e Interface..."
X11_PKGS=("x11-repo" "termux-x11-repo" "xterm" "tigervnc" "fluxbox")
for pkg in "${X11_PKGS[@]}"; do
    pkg install "$pkg" -y
done

# 4. Termux API e Ferramentas Extras
echo "Instalando Termux-API e utilitários..."
EXTRAS=("termux-api" "curl" "wget" "nano" "htop")
for extra in "${EXTRAS[@]}"; do
    pkg install "$extra" -y
done

echo "--- ✅ TUDO PRONTO! ---"
echo "Ambiente Python, C, X11 e API configurados."
