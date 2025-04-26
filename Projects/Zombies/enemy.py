__author__ = 'andrewapperley'

import character


class EnemyState(character.CharacterState):

    ATTACK = 2


class Enemy(character.Character):

    _state = EnemyState.IDLE

    def __init__(self, image, enemyBatch, elevationGroup):
        super(Enemy, self).__init__(image, enemyBatch, elevationGroup)

    def attack(self):
        super(Enemy, self).attack()
        pass