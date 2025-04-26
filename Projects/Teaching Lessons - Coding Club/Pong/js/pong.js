/**
 * Created by andrewapperley on 14-12-26.
 */


var canvas = document.getElementById("main-canvas");
var canvas_context = canvas.getContext("2d");
canvas_context.font = "30px Helvetica";
var max_fps = 60.0;
var max_score = 10;
canvas.addEventListener("keydown", onKeyPress, true);

/*
    Game States
    0 = Game over
    1 = Playing
*/

var game_state = 0

var players = [];

var ball = {
    size : 15,
    x : 0,
    y : 0,
    vx : 0.2,
    vy : 0.25,
    speed : 1,
    colour : "#ffffff",

    reset : function() {
        this.speed = 1;
        this.vx = 0.5;
        this.vy = 0.25;
        this.x = (canvas.width - this.size) / 2;
        this.y = (canvas.height - this.size) / 2;
    },

    update : function() {
        if (this.y <= 0) {
            this.vy = this.speed;
        } else if (this.y + this.size >= canvas.height) {
            this.vy = this.speed * -0.25;
        } else if (this.x + this.size >= players[1].x && ((this.y >= players[1].y || this.y + this.size >= players[1].y) && (this.y + this.size <= players[1].y + players[1].height || this.y <= players[1].y + players[1].height))) {
            this.vx = this.speed * -0.5;
            this.speed += 0.1;
        } else if (this.x <= players[0].x + players[0].width && ((this.y >= players[0].y || this.y + this.size >= players[0].y) && (this.y + this.size <= players[0].y + players[0].height || this.y <= players[0].y + players[0].height))) {
            this.vx = this.speed;
            this.speed += 0.1;
        }

        if (this.x + this.size >= canvas.width) {
            players[0].score += 1;
            ball.reset();
        } else if (this.x <= 0) {
            players[1].score += 1;
            ball.reset();
        } else {
            this.x += this.vx;
            this.y += this.vy;
        }
    },

    draw : function() {
        canvas_context.fillStyle = this.colour;
        canvas_context.fillRect(this.x, this.y, this.size, this.size);
    }
};

function Player(side) {

    var player = {};

    player.side = side;
    player.width = 10;
    player.height = 50;
    player.x = 0;
    player.y = 0;
    player.colour = "#ffffff";
    player.score = 0;

    player.reset = function() {
        this.x = (side == 0) ? 5 : canvas.width - player.width - 5;
        this.y = (canvas.height - player.height) / 2;
    };

    player.draw = function() {
        canvas_context.fillStyle = this.colour;
        canvas_context.fillRect(this.x, this.y, this.width, this.height);
    };

    return player;
}

function setup() {
//    Set Game state to Playing (1)
    game_state = 1;
    canvas.removeEventListener("mousedown", setup, true);
    players = [];
//    Setup Player 1
    players.push(Player(0));
    players[0].reset();
    players[0].draw();
//    Setup Player 2
    players.push(Player(1));
    players[1].reset();
    players[1].draw();
//    Setup Ball
    ball.reset();
//    Setup Game Loop
    clearInterval(this.timer);
    this.timer = setInterval(function () {update();}, 1.0/max_fps);
    canvas.focus();
}

function onKeyPress(e) {
    var code = e.keyCode;
    switch (code) {
        // Move Player 0
        case 87:
            console.log("Up");
            players[0].y -= 30;
            break;
        case 83:
            console.log("Down");
            players[0].y += 30;
            break;
        // Move Player 1
        case 38:
            console.log("Up");
            players[1].y -= 30;
            break;
        case 40:
            console.log("Down");
            players[1].y += 30;
            break;
    }
}

function drawMiddleLines() {
    var x = (canvas.width - 3)/2;
    var y = -5;
    while (y < canvas.height) {
        y += 5;
        canvas_context.moveTo(x, y);
        y += 10;
        canvas_context.lineTo(x, y);
        canvas_context.lineWidth = 5;
        canvas_context.strokeStyle = "#ffffff";
        canvas_context.stroke();
    }
}

function end_game() {
    clearInterval(this.timer);
    canvas_context.clearRect(0,0,canvas.width,canvas.height);
    canvas_context.fillText("Game Over! Click to restart", 70, 40);
    canvas.addEventListener("mousedown", setup, true);
}

function update() {
//    Update Ball
    ball.update();
//    Update Game state
    if (players[0].score == max_score || players[1].score == max_score) {
        game_state = 0;
        end_game();
    } else {
        draw();
    }
}

function draw() {
    canvas_context.clearRect(0,0,canvas.width,canvas.height);
    //drawMiddleLines();
//    Draw Ball
    ball.draw();
//    Draw Players
    for (var player in players) {
        players[player].draw();
//    Draw Score
        canvas_context.fillText(players[player].score, (player == 0) ? 20 : canvas.width - 40, 40);
    }
}

function main() {
    setup();
}

main();