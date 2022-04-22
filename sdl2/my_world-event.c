#include <SDL2/SDL.h>

enum Events {
  QUIT,
  NOTHING,
  LEFT,
  RIGHT,
  UP,
  DOWN,
  RETURN,
  SPACE,
  KEY_A,
  KEY_B,
};


static int Key_Press_Event(SDL_Event event) {
  switch (event.key.keysym.sym) {
    case SDLK_LEFT:
      return LEFT;
      break;
    case SDLK_RIGHT:
      return RIGHT;
      break;
    case SDLK_UP:
      return UP;
      break;
    case SDLK_DOWN:
      return DOWN;
      break;
    case SDLK_RETURN:
      return RETURN;
      break;
    case SDLK_SPACE:
      return SPACE;
      break;
    case SDLK_x:
      return KEY_A;
      break;
    case SDLK_z:
      return KEY_B;
      break;
    default:
      return NOTHING;
      break;
  }
}


enum Events Press_Event(void) {
  SDL_Event event;
  enum Events v = NOTHING;

  if (SDL_PollEvent(&event)) {
    switch (event.type) {
      case SDL_QUIT:
        v = QUIT;
        break;
      case SDL_KEYDOWN:
        v = Key_Press_Event(event);
        break;
      default:
        break;
    }
  }
  return v;
}
