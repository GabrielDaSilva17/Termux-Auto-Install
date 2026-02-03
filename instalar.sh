#!/data/data/com.termux/files/usr/bin/bash

# Para o script se houver erro
set -e

echo "--- 🚀 INICIANDO INSTALAÇÃO COMPLETA (GABRIEL-TERMUX) ---"

# 1. Atualização e Repositórios Específicos
echo "Configurando repositórios (X11 e API)..."
pkg update -y
pkg install x11-repo termux-api -y
pkg install sdl2 -y

# 2. Base de Compilação e Python
echo "Instalando Python e Compiladores..."
TOOLS=("python" "python-pip" "clang" "make" "binutils" "git" "cmake")
for tool in "${TOOLS[@]}"; do
    pkg install "$tool" -y
done

# Criar atalho do GCC apontando para o Clang
ln -sf $PREFIX/bin/clang $PREFIX/bin/gcc

# 3. Utilitários Extras (Estrutura original)
echo "Instalando ferramentas de suporte..."
EXTRAS=("curl" "wget" "nano" "htop")
for extra in "${EXTRAS[@]}"; do
    pkg install "$extra" -y
done

echo "--- ✅ AMBIENTE CONFIGURADO ---"

# 4. Download dos arquivos do seu Programa Gráfico
echo "Baixando fontes do projeto..."
curl -LO https://raw.githubusercontent.com/GabrielDaSilva17/test-termux/main/config.h
curl -LO https://raw.githubusercontent.com/GabrielDaSilva17/test-termux/main/programa.c

# 5. Compilação
echo "--- 🛠️ COMPILANDO PROGRAMA GRÁFICO ---"
# O compilador usa o programa.c e busca definições no config.h
gcc programa.c -o meu_app -lSDL2

echo "✅ Compilação concluída!"

# 6. Inicialização do ambiente gráfico
echo "Iniciando servidor X11..."
termux-x11 :0 &
export DISPLAY=:0

sleep 2 # Aguarda o servidor estabilizar
echo "Executando o programa..."
./meu_app
