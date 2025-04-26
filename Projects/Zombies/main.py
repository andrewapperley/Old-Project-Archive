__author__ = 'andrewapperley'

import pyglet
import world

gameDisplay = pyglet.window.Window()
_world = world.World(gameDisplay)


@gameDisplay.event
def on_draw():
    gameDisplay.clear()
    _world.draw()


def run():
    pyglet.app.run()


if __name__ == "__main__":
    run()