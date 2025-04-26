#!/usr/bin/env python

import sys, pygame

pygame.init()

#Ball class

class Ball(pygame.sprite.Sprite):
    
    def __init__(self):
        self.x, self.y = screenWidth/2, screenHeight/2
        self.speed_x = -3
        self.speed_y = 3
        self.size = 8

    def movement(self):
        self.x += self.speed_x
        self.y += self.speed_y
        
        if self.y <= 0 or self.y >= screenHeight-self.size:
            self.speed_y *= -1
        
        if self.x <= 0:
            enemy.score += 1
            self.__init__()
        elif self.x >= screenWidth-self.size:
            player.score += 1
            self.__init__()
            
        if self.x <= player.x + player.width:
            for i in range(player.y, player.height + player.y):
                if self.y == i:
                    #collided with players paddle
                    self.speed_x *= -1.15
        elif self.x >= enemy.x:
            for i in range(enemy.y, enemy.height + enemy.y):
                if self.y == i:
                    #collided with enemies paddle
                    self.speed_x *= -1.15

    def render(self):
        pygame.draw.rect(screen, (255, 255, 255), (self.x, self.y, self.size, self.size))
    
    

#Paddle class

class Player(pygame.sprite.Sprite):
    
    def __init__(self, type):
        self.type = type
        self.score = 0
        self.width = 10
        self.height = 40
        if self.type == 'left':
            self.x = 10
        elif self.type == 'right':
            self.x = screenWidth - self.width - 10
        self.y = (screenHeight - self.height)/2
    
    def renderScore(self):
        font = pygame.font.Font(None, 36)
        text = font.render("%d" % (self.score), 1, (255, 255, 255))
        if self.type == 'left':
            if self.score == 10:
                print "Player wins!!"
                exit()
            screen.blit(text, (50, 10))
        elif self.type == 'right':
            if self.score == 10:
                print "Enemy wins!!"
                exit()
            screen.blit(text, (screenWidth - 50 - font.size("%d" % (self.score))[0], 10))
    
    def movement(self):
        keys = pygame.key.get_pressed()
        if self.type == 'left':
            if keys[pygame.K_w]:
                if self.y >= 10:
                    self.y -= 10
            if keys[pygame.K_s]:
                if self.y <= screenHeight - self.height - 10:
                    self.y += 10
        elif self.type == 'right':
            if keys[pygame.K_UP]:
                if self.y >= 10:
                    self.y -= 10
            if keys[pygame.K_DOWN]:
                if self.y <= screenHeight - self.height - 10:
                    self.y += 10
    
    
    def render(self):
        pygame.draw.rect(screen, (255, 255, 255), (self.x, self.y, self.width, self.height))

screenWidth, screenHeight = 640, 480
screen = pygame.display.set_mode((screenWidth, screenHeight))
pygame.display.set_caption("Pong")
pygame.font.init()
clock = pygame.time.Clock()
FPS = 60

ball = Ball()
player = Player('left')
enemy = Player('right')

while True:
    #process
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            print "Game exited by user"
            exit()
    
    ball.movement()
    player.movement()
    enemy.movement()
    
    screen.fill((0, 0, 0))
    
    ball.render()
    player.render()
    enemy.render()
    
    player.renderScore()
    enemy.renderScore()
    
    pygame.display.flip()
    clock.tick(FPS)
