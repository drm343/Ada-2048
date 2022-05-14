#!/usr/bin/env python3
from enum import Enum, auto
import ctypes


matrix_2048 = (ctypes.c_int * 4) * 4


# type Process_State is (SKIP, WIN, LOST, CONTINUE);
class Process_State(Enum):
    SKIP = 0
    WIN = auto()
    LOST = auto()
    CONTINUE = auto()


def print_board(board):
    for i in board:
        print("[", end = "")
        counter = 1
        for j in i:
            if counter >= 4:
                print(j, end = "")
            else:
                print(j, end =", ")
            counter = counter + 1
        print("]")


class BaseGame:
    def __init__(self, lib_path = "./libmatrix_2048.so.1.0.0"):
        self.ada = ctypes.CDLL(lib_path)
        self.score = ctypes.c_int(0)
        self.board = matrix_2048()
        self.new_board = matrix_2048()

    def __enter__(self):
        self.ada.matrix_2048init.restype = None
        self.ada.matrix_2048init()
        return self

    def __exit__(self, type, value, traceback):
        self.ada.matrix_2048final.restype = None
        self.ada.matrix_2048final()

    # ----------------- #
    # New Game          #
    # ----------------- #
    def new_game(self):
        self.score = ctypes.c_int(0)
        self.board = matrix_2048()
        self.new_board = matrix_2048()
        self.set_number()

    # ----------------- #
    # Direction Change  #
    # ----------------- #
    def swap(self, board, new_board):
        self.ada.swap(board, new_board)

    def rotate_right(self, board, new_board):
        self.ada.rotate_right(board, new_board)

    def rotate_left(self, board, new_board):
        self.ada.rotate_left(board, new_board)


    # ----------------- #
    # Add number        #
    # ----------------- #
    def set_number(self):
        self.ada.set_number(self.board)


    # ----------------- #
    # Game Rule Process #
    # ----------------- #
    def process_rule(self):
        state = Process_State(self.ada.process_rule(self.new_board, ctypes.byref(self.score)))
        return state
