#!/data/data/com.termux/files/usr/bin/bash

# Para o script imediatamente se algum comando falhar
set -e

echo "--- Verificando Condições do Sistema ---"

# Verifica o nível da bateria via termux-api (se disponível) ou via sistema
BATERIA=$(termux-battery-status | grep -oP '"percentage": \K\d+' || echo "100")

if [ "$BATERIA" -lt 20 ]; then
    echo "Erro: Bateria muito baixa ($BATERIA%). Conecte ao carregador!"
    exit 1
fi

echo "Bateria em $BATERIA%. Iniciando automação..."

# Atualização de repositórios
pkg update -y && pkg upgrade -y

# Ferramentas necessárias
TOOLS=("python" "clang" "git" "make" "binutils" "termux-api")

for tool in "${TOOLS[@]}"; do
    if command -v $tool &> /dev/null; then
        echo "$tool já está instalado. Pulando..."
    else
        echo "Instalando: $tool..."
        pkg install "$tool" -y
    fi
done

# Criar link simbólico para o gcc (apontando para o clang)
if [ ! -f $PREFIX/bin/gcc ]; then
    ln -sf $PREFIX/bin/clang $PREFIX/bin/gcc
fi

echo "--- Tudo pronto, Gabriel! Ambiente configurado. ---"
