__author__ = 'andrewapperley'
import pyglet
from pyglet.sprite import Sprite
import math


class CharacterState:

    IDLE = 0
    MOVING = 1


class CharacterMovementDirection:
    IDLE = 0
    UP = 1
    DOWN = 2
    LEFT = 3
    RIGHT = 4
    UP_LEFT = 5
    UP_RIGHT = 6
    DOWN_LEFT = 7
    DOWN_RIGHT = 8


class Character(Sprite):
    direction = CharacterMovementDirection.IDLE
    speed = 25

    def get_state(self):
        return self.state

    def set_state(self, newState):
        self._state = newState
        # Change animation to represent new state

    _state = CharacterState.IDLE
    state = property(get_state, set_state)

    def rotateToPoint(self, newPoint):
        self.rotation = math.atan2(self.x - newPoint[0], self.y - newPoint[1]) * 180 / math.pi

    def attack(self):
        # Override
        pass

    def moving(self, dt):
        pass
        # if self.direction == CharacterMovementDirection.IDLE:
        #     return
        # x = self.x
        # y = self.y
        # delta = dt * self.speed
        #
        # if self.direction == CharacterMovementDirection.UP:
        #     y += delta
        # elif self.direction == CharacterMovementDirection.DOWN:
        #     y -= delta
        # elif self.direction == CharacterMovementDirection.LEFT:
        #     x -= delta
        # elif self.direction == CharacterMovementDirection.RIGHT:
        #     x += delta
        # elif self.direction == CharacterMovementDirection.UP_LEFT:
        #     y += delta
        #     x -= delta
        # elif self.direction == CharacterMovementDirection.UP_RIGHT:
        #     y += delta
        #     x += delta
        # elif self.direction == CharacterMovementDirection.DOWN_LEFT:
        #     y -= delta
        #     x -= delta
        # elif self.direction == CharacterMovementDirection.DOWN_RIGHT:
        #     y -= delta
        #     x += delta
        #
        # self.set_position(x, y)

    def move(self, direction):
        if self._state != CharacterState.MOVING:
            pyglet.clock.schedule_interval(self.moving, 1/60.0)
        self.direction = direction
        self.set_state(CharacterState.MOVING)

    def stop(self):
        pyglet.clock.unschedule(self.moving)
        self.direction = CharacterMovementDirection.IDLE
        self.set_state(CharacterState.IDLE)

    def __init__(self, image, batch, elevationGroup):
        super(Character, self).__init__(image, batch=batch, group=elevationGroup)
        self.image.anchor_x = self.image.width / 2
        self.image.anchor_y = self.image.height / 2

    def __del__(self):
        pyglet.clock.unschedule(self.moving)