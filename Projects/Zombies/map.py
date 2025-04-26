__author__ = 'andrewapperley'

import pyglet
from json_map import Map as Map_Generator

class MapMovementDirection:
    IDLE = 0
    UP = 1
    DOWN = 2
    LEFT = 3
    RIGHT = 4
    UP_LEFT = 5
    UP_RIGHT = 6
    DOWN_LEFT = 7
    DOWN_RIGHT = 8

class Map(object):

    viewport_size = (0, 0)
    _map = None

    def move_map(self, direction):
        x = self._map.x
        y = self._map.y
        delta = 4
        if direction == MapMovementDirection.UP:
            y -= delta
        elif direction == MapMovementDirection.DOWN:
            y += delta
        elif direction == MapMovementDirection.LEFT:
            x -= delta
        elif direction == MapMovementDirection.RIGHT:
            x += delta
        elif direction == MapMovementDirection.UP_LEFT:
            y -= delta
            x -= delta
        elif direction == MapMovementDirection.UP_RIGHT:
            y -= delta
            x += delta
        elif direction == MapMovementDirection.DOWN_LEFT:
            y += delta
            x -= delta
        elif direction == MapMovementDirection.DOWN_RIGHT:
            y += delta
            x += delta

        x = int(x)
        y = int(y)

        self._map.set_focus(x, y)

    def draw(self):
        self._map.draw()

    def generate(self):
        map_file = pyglet.resource.file("map.json")
        self._map = Map_Generator.load_json(map_file)
        self._map.set_viewport(0, 0, self.viewport_size[0], self.viewport_size[1])

    def __init__(self, size):
        self.viewport_size = size
        self.generate()