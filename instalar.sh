#!/data/data/com.termux/files/usr/bin/bash

echo "--- Iniciando Automação GabrielDaSilva17 ---"

# Atualiza os repositórios
pkg update -y && pkg upgrade -y

# Lista de ferramentas
# Nota: No Termux, o 'clang' é o compilador C padrão que substitui o gcc
TOOLS=("python" "clang" "git" "make" "binutils")

for tool in "${TOOLS[@]}"; do
    echo "Instalando: $tool..."
    pkg install "$tool" -y
done

# Criando um atalho para o 'gcc' usar o 'clang' (comum no Termux)
ln -sf $PREFIX/bin/clang $PREFIX/bin/gcc

echo "--- Instalação Finalizada com Sucesso! ---"
