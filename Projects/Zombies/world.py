__author__ = 'andrewapperley'

import pyglet
from pyglet.window import key
from pyglet.window import mouse
import map
import enemy
import player
from character import CharacterMovementDirection


class World(object):
    map = None
    player = None
    enemies = []
    keys = key.KeyStateHandler()

    def update(self):
        # Check for collisions
        # Change Viewport if player is moving
        if self.player.direction != CharacterMovementDirection.IDLE:
            self.map.move_map(self.player.direction)

    def draw(self):
        self.update()
        self.map.draw()
        self.player.draw()

    # This function will change the players direction and move them in that direction
    def on_key_press(self, symbol, modifiers):
        if symbol == key.A or symbol == key.D or symbol == key.W or symbol == key.S:

            if symbol == key.A:
                if self.keys[key.W]:
                    self.player.move(CharacterMovementDirection.UP_LEFT)
                elif self.keys[key.S]:
                    self.player.move(CharacterMovementDirection.DOWN_LEFT)
                else:
                    self.player.move(CharacterMovementDirection.LEFT)
            elif symbol == key.D:
                if self.keys[key.W]:
                    self.player.move(CharacterMovementDirection.UP_RIGHT)
                elif self.keys[key.S]:
                    self.player.move(CharacterMovementDirection.DOWN_RIGHT)
                else:
                    self.player.move(CharacterMovementDirection.RIGHT)
            elif symbol == key.W:
                if self.keys[key.A]:
                    self.player.move(CharacterMovementDirection.UP_LEFT)
                elif self.keys[key.D]:
                    self.player.move(CharacterMovementDirection.UP_RIGHT)
                else:
                    self.player.move(CharacterMovementDirection.UP)
            elif symbol == key.S:
                if self.keys[key.A]:
                    self.player.move(CharacterMovementDirection.DOWN_LEFT)
                elif self.keys[key.D]:
                    self.player.move(CharacterMovementDirection.DOWN_RIGHT)
                else:
                    self.player.move(CharacterMovementDirection.DOWN)

    # This function will stop the players direction
    def on_key_release(self, symbol, modifiers):
        if symbol == key.A or symbol == key.D or symbol == key.W or symbol == key.S:
            if not self.keys[key.A] and not self.keys[key.D] and not self.keys[key.W] and not self.keys[key.S]:
                self.player.stop()
            else:
                if symbol == key.A:
                    if self.keys[key.W]:
                        self.player.move(CharacterMovementDirection.UP)
                    elif self.keys[key.S]:
                        self.player.move(CharacterMovementDirection.DOWN)
                elif symbol == key.D:
                    if self.keys[key.W]:
                        self.player.move(CharacterMovementDirection.UP)
                    elif self.keys[key.S]:
                        self.player.move(CharacterMovementDirection.DOWN)
                elif symbol == key.W:
                    if self.keys[key.A]:
                        self.player.move(CharacterMovementDirection.LEFT)
                    elif self.keys[key.D]:
                        self.player.move(CharacterMovementDirection.RIGHT)
                elif symbol == key.S:
                    if self.keys[key.A]:
                        self.player.move(CharacterMovementDirection.LEFT)
                    elif self.keys[key.D]:
                        self.player.move(CharacterMovementDirection.RIGHT)

    # This will determine the players angle
    def on_mouse_motion(self, x, y, dx, dy):
        self.player.rotateToPoint((x, y))

    # This will have the player attack
    def on_mouse_press(self, x, y, button, modifiers):
        if button == pyglet.window.mouse.LEFT:
            self.player.attack()

    # This will stop the players movement
    def on_mouse_leave(self, x, y):
        self.player.stop()

    def __init__(self, gameDisplay):
        # Create the map
        self.map = map.Map((gameDisplay.width, gameDisplay.height))
        # Register callback events
        gameDisplay.push_handlers(self.on_key_press)
        gameDisplay.push_handlers(self.on_key_release)
        gameDisplay.push_handlers(self.on_mouse_motion)
        gameDisplay.push_handlers(self.on_mouse_press)
        gameDisplay.push_handlers(self.on_mouse_leave)
        gameDisplay.push_handlers(self.keys)
        # Create the player
        self.player = player.Player(pyglet.image.load('player.png'), None, None)
        self.player.set_position(gameDisplay.width/2, gameDisplay.height/2)
        # Create the enemy spawns