#include <SDL2/SDL.h>
#include "config.h" // Importa suas configurações personalizadas

int main(int argc, char* argv[]) {
    SDL_Init(SDL_INIT_VIDEO);

    SDL_Window* window = SDL_CreateWindow(
        TITULO, 
        SDL_WINDOWPOS_CENTERED, 
        SDL_WINDOWPOS_CENTERED, 
        LARGURA, 
        ALTURA, 
        SDL_WINDOW_SHOWN
    );

    SDL_Renderer* renderer = SDL_CreateRenderer(window, -1, 0);
    
    // Usa as cores definidas no config.h
    SDL_SetRenderDrawColor(renderer, COR_R, COR_G, COR_B, 255);
    SDL_RenderClear(renderer);
    SDL_RenderPresent(renderer);

    SDL_Delay(5000); 

    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
