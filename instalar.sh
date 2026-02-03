#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# GABRIEL-TERMUX ULTRA EDITION 2026
# ==========================================

# Cores
VERDE="\e[92m"; AMARELO="\e[33m"; CIANO="\e[36m"; VERMELHO="\e[31m"; RESET="\e[0m"; NEGRITO="\e[1m"; ROXO="\e[35m"

# Título Fixo (Não mudará mais)
clear
echo -e "${AMARELO}${NEGRITO}============================================${RESET}"
echo -e "\n${ROXO} [ GABRIEL-TERMUX ULTRA EDITION 2026 ]${RESET}\n"
echo -e "${AMARELO}${NEGRITO}============================================${RESET}"
sleep 1

# 1. CORREÇÃO DE REPOSITÓRIOS & LOLCAT (Prioridade Máxima)
echo -e "${CIANO}Configurando base do sistema...${RESET}"
termux-change-repo << EOF
OK
EOF
pkg update -y

# Instalação blindada do Lolcat (para o banner não falhar)
echo -ne "${AMARELO}Instalando sistema de cores... ${RESET}"
if pkg install lolcat -y > /dev/null 2>&1; then
    echo -e "${VERDE}OK (Via PKG)${RESET}"
else
    echo -e "${AMARELO}Alternando para Ruby...${RESET}"
    pkg install ruby -y > /dev/null 2>&1
    gem install lolcat > /dev/null 2>&1
fi

# 2. FUNÇÃO DE INSTALAÇÃO SEGURA
install_package() {
    pkg_name=$1
    echo -ne "${AMARELO}Checando $pkg_name... ${RESET}"
    if dpkg -s "$pkg_name" &> /dev/null; then
        echo -e "${VERDE}OK ✅${RESET}"
    else
        pkg install "$pkg_name" -y > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo -e "${VERDE}Instalado${RESET}"
        else
            echo -e "${VERMELHO}Erro (Tentando novamente...)${RESET}"
            pkg install "$pkg_name" -y
        fi
    fi
}

# 3. LISTA COMPLETA DE PACOTES (Nada foi removido)
packages=(
    "figlet" "ncurses-utils" "git" "python" "python-pip" 
    "clang" "make" "cmake" "binutils" "curl" "wget" "perl" "ruby" 
    "php" "nodejs" "bash" "nano" "zip" "unzip" "openssl" "openssh" 
    "zsh" "ffmpeg" "htop" "screen" "jq" "rsync" "tree" "termux-api" 
    "termux-x11" "sdl2" "neofetch" "cmatrix" "cowsay" "fortune" 
    "sl" "ranger" "proot" "proot-distro" "tsu" "man" "vim" "proxychains-ng"
)

for pkg in "${packages[@]}"; do
    install_package "$pkg"
done

# Configurações Finais
echo -e "${CIANO}Finalizando configurações...${RESET}"
pip install --upgrade pip > /dev/null 2>&1
pip install yt-dlp speedtest-cli > /dev/null 2>&1
sshd > /dev/null 2>&1
ln -sf $PREFIX/bin/clang $PREFIX/bin/gcc > /dev/null 2>&1

# 4. CHECKLIST VISUAL (Conferindo versões)
clear
echo -e "${AMARELO}${NEGRITO}🔎 CONFERINDO SISTEMA...${RESET}"
echo " "
sleep 1

check_version() {
    if command -v $1 &> /dev/null; then
        echo -e "${CIANO}$2:${RESET} $($3)"
    else
        echo -e "${CIANO}$2:${RESET} ${VERMELHO}Faltando${RESET}"
    fi
}

check_version "python" "Python" "python --version"
check_version "node"   "NodeJS" "node -v"
check_version "clang"  "Clang " "clang --version | head -n 1"
check_version "git"    "Git   " "git --version"
echo " "
echo -e "${AMARELO}Gerando Banner Permanente...${RESET}"
sleep 2

# 5. CONFIGURAÇÃO VISUAL PERMANENTE (.bashrc)
echo "" > ~/.bashrc

cat << 'EOF' >> ~/.bashrc
# --- GABRIEL CONFIG ---
alias atualizar='pkg update && pkg upgrade -y'
alias fechar='pkill termux-x11'
alias ssh-on='sshd && ifconfig | grep inet'
alias cls='clear'
alias limpar='rm -rf ~/.termux/shell_history'

clear

# 1. BANNER QUADRADO GRANDE
draw_banner() {
    if command -v lolcat &> /dev/null; then
        echo "╔═══════════════════════════════════════════════════════════╗" | lolcat
        figlet -f slant "   GABRIEL   " | lolcat
        echo "╚═══════════════════════════════════════════════════════════╝" | lolcat
    else
        echo "-------------------------------------------------------------"
        figlet -f slant "   GABRIEL   "
        echo "-------------------------------------------------------------"
    fi
}
draw_banner

# 2. STATUS (Embaixo do Banner)
check() {
    if command -v $1 &> /dev/null; then echo -e "\033[1;32mON\033[0m"; else echo -e "\033[1;31mOFF\033[0m"; fi
}

echo -e "    \033[1;33mPYTHON:\033[0m $(check python)   \033[1;33mNODE:\033[0m $(check node)   \033[1;33mSSH:\033[0m $(check sshd)"
echo -e "    \033[1;33mCLANG :\033[0m $(check clang)   \033[1;33mGIT :\033[0m $(check git)    \033[1;33mX11:\033[0m $(check termux-x11)"
echo " "

# 3. ANDROID INFO
neofetch --ascii_distro android --disable packages shell term resolution

# Prompt Customizado
export PS1='\[\e[1;32m\]Gabriel\[\e[0m\]@\[\e[1;34m\]Termux\[\e[0m\]:\[\e[1;33m\]\w\[\e[0m\] $ '
EOF

source ~/.bashrc

# Tela Final
clear
echo -e "${VERDE}${NEGRITO}INSTALAÇÃO COMPLETA!${RESET}"
echo -e "${VERDE}[✓]${RESET} Banner Quadrado"
echo -e "${VERDE}[✓]${RESET} Todos os Pacotes"
echo -e "${VERDE}[✓]${RESET} Android Info"
echo " "
echo "Feche o Termux e abra novamente para ver o resultado."
