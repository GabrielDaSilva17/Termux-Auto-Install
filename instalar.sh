#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# GABRIEL-TERMUX ULTRA EDITION 2026 (FIX)
# ==========================================

# Cores
VERDE="\e[92m"; AMARELO="\e[33m"; CIANO="\e[36m"; VERMELHO="\e[31m"; RESET="\e[0m"; NEGRITO="\e[1m"; ROXO="\e[35m"

# Título
clear
echo -e "${AMARELO}${NEGRITO}============================================${RESET}"
echo -e "\n${ROXO} [ GABRIEL-TERMUX ULTRA EDITION 2026 ]${RESET}\n"
echo -e "${AMARELO}${NEGRITO}============================================${RESET}"
sleep 1

# 1. CORREÇÃO CRÍTICA DE REPOSITÓRIOS
# O erro anterior ocorria porque o x11-repo era instalado mas não lido
echo -e "${CIANO}Configurando repositórios X11...${RESET}"
termux-change-repo << EOF
OK
EOF

# Instala os repositórios PRIMEIRO
pkg install x11-repo termux-api game-repo -y

# ATUALIZA A LISTA AGORA (Isso corrige o erro 'Unable to locate')
echo -e "${AMARELO}Sincronizando novos repositórios...${RESET}"
pkg update -y

# 2. INSTALAÇÃO DO LOLCAT (Visual)
echo -ne "${AMARELO}Checando cores... ${RESET}"
if pkg install lolcat -y > /dev/null 2>&1; then
    echo -e "${VERDE}OK (Pkg)${RESET}"
else
    echo -e "${AMARELO}Usando Ruby...${RESET}"
    pkg install ruby -y > /dev/null 2>&1
    gem install lolcat > /dev/null 2>&1
fi

# 3. FUNÇÃO DE INSTALAÇÃO
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

# 4. LISTA DE PACOTES
# Removi termux-x11 e sdl2 daqui para instalar com comando especial abaixo
packages=(
    "figlet" "ncurses-utils" "git" "python" "python-pip" 
    "clang" "make" "cmake" "binutils" "curl" "wget" "perl" "ruby" 
    "php" "nodejs" "bash" "nano" "zip" "unzip" "openssl" "openssh" 
    "zsh" "ffmpeg" "htop" "screen" "jq" "rsync" "tree" "termux-api" 
    "neofetch" "cmatrix" "cowsay" "fortune" "sl" "ranger" 
    "proot" "proot-distro" "tsu" "man" "vim" "proxychains-ng"
)

for pkg in "${packages[@]}"; do
    install_package "$pkg"
done

# 5. INSTALAÇÃO ESPECIAL X11 (Forçando o reconhecimento)
echo -e "${CIANO}Instalando Interface Gráfica (X11/SDL2)...${RESET}"
# Tenta o pacote normal, se falhar tenta o nightly
if ! pkg install termux-x11 -y; then
    pkg install termux-x11-nightly -y
fi
pkg install sdl2 -y

# Configurações Finais
echo -e "${CIANO}Finalizando...${RESET}"
pip install --upgrade pip > /dev/null 2>&1
pip install yt-dlp speedtest-cli > /dev/null 2>&1
sshd > /dev/null 2>&1
ln -sf $PREFIX/bin/clang $PREFIX/bin/gcc > /dev/null 2>&1

# 6. CONFIGURAÇÃO VISUAL PERMANENTE
echo "" > ~/.bashrc

cat << 'EOF' >> ~/.bashrc
# --- GABRIEL CONFIG ---
alias atualizar='pkg update && pkg upgrade -y'
alias fechar='pkill termux-x11'
alias ssh-on='sshd && ifconfig | grep inet'
alias cls='clear'
alias limpar='rm -rf ~/.termux/shell_history'

clear

# 1. BANNER QUADRADO
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

# 2. STATUS
check() {
    if command -v $1 &> /dev/null; then echo -e "\033[1;32mON\033[0m"; else echo -e "\033[1;31mOFF\033[0m"; fi
}

echo -e "    \033[1;33mPYTHON:\033[0m $(check python)   \033[1;33mNODE:\033[0m $(check node)   \033[1;33mSSH:\033[0m $(check sshd)"
echo -e "    \033[1;33mCLANG :\033[0m $(check clang)   \033[1;33mGIT :\033[0m $(check git)    \033[1;33mX11:\033[0m $(check termux-x11)"
echo " "

# 3. ANDROID INFO
neofetch --ascii_distro android --disable packages shell term resolution

export PS1='\[\e[1;32m\]Gabriel\[\e[0m\]@\[\e[1;34m\]Termux\[\e[0m\]:\[\e[1;33m\]\w\[\e[0m\] $ '
EOF

source ~/.bashrc

# Tela Final
clear
echo -e "${VERDE}${NEGRITO}INSTALAÇÃO COMPLETA!${RESET}"
echo -e "${VERDE}[✓]${RESET} Repositórios Sincronizados"
echo -e "${VERDE}[✓]${RESET} X11 e SDL2 Corrigidos"
echo " "
echo "Reinicie o Termux."
