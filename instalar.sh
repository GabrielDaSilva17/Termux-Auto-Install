#!/data/data/com.termux/files/usr/bin/bash

# Para o script se houver erro
set -e

echo "--- 🚀 INICIANDO INSTALAÇÃO AUTOMÁTICA GABRIEL-TERMUX ---"

# 1. Repositórios e Instalação do comando termux-x11
echo "Configurando repositórios e instalando X11..."
pkg update -y
pkg install x11-repo termux-api -y
# Instalando o pacote que contém o comando termux-x11
pkg install termux-x11 sdl2 -y 

# 2. Base de Compilação e Python
echo "Instalando Python e Compiladores..."
TOOLS=("python" "python-pip" "clang" "make" "binutils" "git" "cmake")
for tool in "${TOOLS[@]}"; do
    pkg install "$tool" -y
done

# Criar atalho do GCC
ln -sf $PREFIX/bin/clang $PREFIX/bin/gcc

# 3. Utilitários Extras
echo "Instalando ferramentas de suporte..."
EXTRAS=("curl" "wget" "nano" "htop")
for extra in "${EXTRAS[@]}"; do
    pkg install "$extra" -y
done

echo "--- ✅ AMBIENTE CONFIGURADO ---"

# 4. Download dos arquivos do projeto
echo "Baixando fontes do projeto..."
curl -LO https://raw.githubusercontent.com/GabrielDaSilva17/test-termux/main/config.h
curl -LO https://raw.githubusercontent.com/GabrielDaSilva17/test-termux/main/programa.c

# 5. Compilação
echo "--- 🛠️ COMPILANDO PROGRAMA GRÁFICO ---"
gcc programa.c -o meu_app -lSDL2

echo "✅ Compilação concluída!"

# 6. Execução Automática
echo "Iniciando servidor X11 e o Programa..."
# Inicia o servidor em segundo plano
termux-x11 :0 &

# Configura o display e força o driver de software para evitar erro de MESA
export DISPLAY=:0
export GALLIUM_DRIVER=llvmpipe

sleep 2 
./meu_app
