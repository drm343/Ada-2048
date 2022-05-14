#!/usr/bin/env python3
import tkinter
import tkinter.font as tkFont
from tkinter import ttk


class Base2048:
    def __init__(self, title = "2048"):
        self.root = tkinter.Tk()
        self.root.title(title)
        self.root.resizable(0, 0)

        self.root.bind('<Return>', self.event_enter)
        self.root.bind('<space>', self.event_space)
        self.root.bind('<Left>', self.behavior_left)
        self.root.bind('<Right>', self.behavior_right)
        self.root.bind('<Up>', self.behavior_up)
        self.root.bind('<Down>', self.behavior_down)
        self.root.bind('x', self.behavior_a)
        self.root.bind('z', self.behavior_b)

        self.style = ttk.Style()
        self.style.configure("board.TLabel", background = "#FFF")
        self.style.configure("board.2.TLabel", background = "#03fc17")
        self.style.configure("board.4.TLabel", background = "#06d617")
        self.style.configure("board.8.TLabel", background = "#08a669")
        self.style.configure("board.16.TLabel", background = "#06c7c4")
        self.style.configure("board.32.TLabel", background = "#06a7c7")
        self.style.configure("board.64.TLabel", background = "#1d06c7")
        self.style.configure("board.128.TLabel", background = "#8306c7")
        self.style.configure("board.256.TLabel", background = "#c706a0")
        self.style.configure("board.512.TLabel", background = "#c7065a")
        self.style.configure("board.1024.TLabel", background = "#dee609")
        self.style.configure("board.2048.TLabel", background = "#FF0000")

        self.score_area()
        self.board_area()
        self.help_area()

    def new_game(self):
        self.running = True
        self.message.set("")

    def gameover(self, message):
        self.running = False
        self.message.set(message)


    def score_area(self):
        font = tkFont.Font(size = 20)

        frame = ttk.Frame(self.root)
        frame.grid()

        ttk.Label(frame, text = "score", padding = 20, font = font).grid(column = 0, row = 0)

        self.score = tkinter.IntVar()

        score = ttk.Label(frame, textvariable = self.score, font = font)
        score.grid(column = 1, row = 0)

        self.message = tkinter.StringVar()
        ttk.Label(frame, textvariable = self.message, padding = 20, font = font).grid(column = 2, row = 0)

        self.gameover("Press space to new game.")


    def board_area(self):
        font = tkFont.Font(size = 20)

        frame = ttk.Frame(self.root, borderwidth = 1, relief = tkinter.GROOVE)
        frame.grid()

        self.board = []
        self.board_label = []
        for i in range(0, 4):
            for j in range(0, 4):
                v = tkinter.IntVar()
                label = ttk.Label(frame, textvariable = v, font = font, width = 5, style = "board.TLabel")
                label.configure(anchor = "center")
                label.grid(row = i, column = j)
                self.board.append(v)
                self.board_label.append(label)

        self.style_text = {}
        self.style_text[2] = "board.2.TLabel"
        self.style_text[4] = "board.4.TLabel"
        self.style_text[8] = "board.8.TLabel"
        self.style_text[16] = "board.16.TLabel"
        self.style_text[32] = "board.32.TLabel"
        self.style_text[64] = "board.64.TLabel"
        self.style_text[128] = "board.128.TLabel"
        self.style_text[256] = "board.256.TLabel"
        self.style_text[512] = "board.512.TLabel"
        self.style_text[1024] = "board.1024.TLabel"
        self.style_text[2048] = "board.2048.TLabel"


    def help_area(self):
        font = tkFont.Font(size = 20)

        frame = ttk.Frame(self.root)
        frame.grid()
        ttk.Label(frame, text = "Use ARROW key to move. Use ENTER key to quit.", padding = 20, font = font).grid(column = 0, row = 0)


    def update_score(self, value):
        self.score.set(value)


    def update_board(self, board):
        for i in range(0, 4):
            for j in range(0, 4):
                v = board[i][j]
                self.board[i * 4 + j].set(v)

                s = self.style_text.get(v)
                if s:
                    self.board_label[i * 4 + j].configure(style = s)
                else:
                    self.board_label[i * 4 + j].configure(style = "board.TLabel")


    # key behavior
    def behavior_left(self, event):
        if self.running:
            self.event_left(event)

    def behavior_right(self, event):
        if self.running:
            self.event_right(event)

    def behavior_up(self, event):
        if self.running:
            self.event_up(event)

    def behavior_down(self, event):
        if self.running:
            self.event_down(event)

    def behavior_a(self, event):
        if self.running:
            self.event_a(event)

    def behavior_b(self, event):
        if self.running:
            self.event_b(event)

    # key event
    def event_enter(self, event):
        pass

    def event_space(self, event):
        pass

    def event_left(self, event):
        pass

    def event_right(self, event):
        pass

    def event_up(self, event):
        pass

    def event_down(self, event):
        pass

    def event_a(self, event):
        pass

    def event_b(self, event):
        pass

    def mainloop(self):
        self.root.mainloop()
