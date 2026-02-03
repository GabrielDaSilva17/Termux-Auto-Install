#!/data/data/com.termux/files/usr/bin/bash

# Cores e Estilo
VERDE="\e[92m"; AMARELO="\e[33m"; CIANO="\e[36m"; VERMELHO="\e[31m"; RESET="\e[0m"; NEGRITO="\e[1m"

clear
echo -e "${AMARELO}${NEGRITO}============================================${RESET}"
echo -e "\n${AMARELO} [${VERDE}Gabriel-Termux${RESET}${VERMELHO} ULTRA EDITION 2026${AMARELO}]${RESET}\n"
echo -e "${AMARELO}${NEGRITO}============================================${RESET}"
sleep 1

# Função de instalação
install_package() {
    pkg_name=$1
    if dpkg -s "$pkg_name" &> /dev/null; then
        echo -e "${VERDE} • $pkg_name já instalado ✅${RESET}"
    else
        echo -e "${VERMELHO} • Instalando $pkg_name...${RESET}"
        pkg install "$pkg_name" -y
        echo -e "${VERDE} • $pkg_name pronto ✅${RESET}"
    fi
}

echo -e "${AMARELO}Otimizando repositórios...${RESET}"
pkg update -y && pkg upgrade -y
pkg install x11-repo termux-api -y

# Lista de pacotes essenciais (Incluindo neofetch e lolcat)
packages=(
    "git" "python" "python-pip" "clang" "make" "cmake" "binutils" 
    "curl" "wget" "perl" "ruby" "php" "nodejs" "bash" "nano" 
    "zip" "unzip" "openssl" "openssh" "zsh" "ffmpeg" "htop" 
    "screen" "jq" "rsync" "tree" "termux-api" "termux-x11" "sdl2"
    "neofetch" "cmatrix" "figlet" "cowsay" "fortune" "sl" "ranger"
    "proot" "proot-distro" "tsu" "man" "vim" "proxychains-ng" "lolcat"
)

for pkg in "${packages[@]}"; do
    install_package "$pkg"
done

# --- CONFIGURAÇÃO DO INÍCIO (BANNER + ANDROID INFO) ---
echo -e "${CIANO}Configurando Banner Gabriel + Info Android...${RESET}"

# 1. Cria o arquivo se não existir
touch ~/.bashrc

# 2. LIMPEZA TOTAL: Remove configurações antigas para não duplicar
sed -i '/figlet/d' ~/.bashrc
sed -i '/neofetch/d' ~/.bashrc
sed -i '/lolcat/d' ~/.bashrc
sed -i '/clear/d' ~/.bashrc
sed -i '/alias/d' ~/.bashrc

# 3. Injeta os Aliases (Atalhos)
echo "alias atualizar='pkg update && pkg upgrade -y'" >> ~/.bashrc
echo "alias fechar='pkill termux-x11'" >> ~/.bashrc
echo "alias ssh-on='sshd && ifconfig | grep inet'" >> ~/.bashrc
echo "alias limpar='rm -rf ~/.termux/shell_history'" >> ~/.bashrc

# 4. INJETA O BANNER NOVO
# O comando 'neofetch --ascii_distro android' força o boneco do Android
cat << 'EOF' >> ~/.bashrc
clear
figlet -f slant "GABRIEL" | lolcat
echo " "
neofetch --ascii_distro android
EOF

# Recarrega as configurações
source ~/.bashrc 2>/dev/null

# --- Instalações Finais ---
pip install --upgrade pip
pip install yt-dlp speedtest-cli

sshd
ln -sf $PREFIX/bin/clang $PREFIX/bin/gcc

# ==========================================
# FASE FINAL
# ==========================================
clear
echo -e "${VERDE}${NEGRITO}=== TUDO PRONTO! ===${RESET}"
echo -e "${VERDE}[✓]${RESET} Banner Colorido Configurado"
echo -e "${VERDE}[✓]${RESET} Info do Android Configurada"
echo " "
echo -e "${AMARELO}Reinicie o Termux para ver o resultado final!${RESET}"
sleep 2

# Teste imediato na tela
clear
figlet -f slant "GABRIEL" | lolcat
echo " "
neofetch --ascii_distro android
