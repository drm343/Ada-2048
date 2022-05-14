#!/usr/bin/env python3
from lib import gui
from lib.game import BaseGame, matrix_2048, Process_State


class Ada2048(gui.Base2048):
    def __init__(self, game):
        super().__init__()
        self.game = game

    def update_screen(self):
        self.update_score(self.game.score.value)
        self.update_board(self.game.board)

    def next_turn(self, state):
        if state == Process_State.WIN:
            self.gameover("You Win. Press space to new game.")
        elif state == Process_State.LOST:
            self.gameover("You LOST. Press space to new game.")

    def event_enter(self, event):
        self.root.destroy()

    def event_space(self, event):
        self.new_game()
        self.game.new_game()
        self.update_screen()

    def event_left(self, event):
        self.game.new_board = self.game.board
        state = self.game.process_rule()
        self.game.board = self.game.new_board
        self.update_screen()
        self.next_turn(state)

    def event_right(self, event):
        self.game.swap(self.game.board, self.game.new_board)
        state = self.game.process_rule()
        self.game.swap(self.game.new_board, self.game.board)
        self.update_screen()
        self.next_turn(state)

    def event_up(self, event):
        self.game.rotate_left(self.game.board, self.game.new_board)
        state = self.game.process_rule()
        self.game.rotate_right(self.game.new_board, self.game.board)
        self.update_screen()
        self.next_turn(state)

    def event_down(self, event):
        self.game.rotate_right(self.game.board, self.game.new_board)
        state = self.game.process_rule()
        self.game.rotate_left(self.game.new_board, self.game.board)
        self.update_screen()
        self.next_turn(state)

    def event_a(self, event):
        self.next_turn(Process_State.WIN)
    def event_b(self, event):
        self.next_turn(Process_State.LOST)


with BaseGame() as game:
    root = Ada2048(game)
    root.mainloop()
