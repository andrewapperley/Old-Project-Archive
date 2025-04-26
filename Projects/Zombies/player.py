__author__ = 'andrewapperley'

import character


class Player(character.Character):

    def __init__(self, image, playerBatch, elevationGroup):
        super(Player, self).__init__(image, playerBatch, elevationGroup)
    
    def attack(self):
        super(Player, self).attack()
        pass