#!/data/data/com.termux/files/usr/bin/bash

# Para o script se houver erro
set -e

echo "--- 🚀 INICIANDO INSTALAÇÃO DE PACOTES (GABRIEL-TERMUX) ---"

# 1. Atualização e Repositórios de Sistema
echo "Configurando repositórios base..."
pkg update -y && pkg upgrade -y

# 2. Ativando Suporte a Gráficos e API
echo "Instalando repositórios X11 e Termux-API..."
pkg install x11-repo termux-api -y
pkg install termux-x11 -y

# 3. Base de Desenvolvimento (Python e C)
echo "Instalando Python e Compiladores..."
TOOLS=("python" "python-pip" "clang" "make" "binutils" "git" "cmake" "sdl2")
for tool in "${TOOLS[@]}"; do
    pkg install "$tool" -y
done

# Criar atalho do GCC (apontando para o Clang)
ln -sf $PREFIX/bin/clang $PREFIX/bin/gcc

# 4. Utilitários de Terminal e Rede
echo "Instalando ferramentas de suporte..."
EXTRAS=("curl" "wget" "nano" "htop")
for extra in "${EXTRAS[@]}"; do
    pkg install "$extra" -y
done

echo "--- ✅ INSTALAÇÃO CONCLUÍDA ---"
echo "O seu ambiente está pronto com Python, C, X11 e API."
