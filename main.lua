
  

    -- function love.load()
    --     player = {}
    --     player.x = 400
    --     player.y = 200
    --     player.speed = 5
    -- end

  
    -- function love.draw()
    --     -- Set the background color to white (255, 255, 255)
    --     love.graphics.clear(255, 255, 255)
    
    --     -- Draw your game elements here
    --     -- They will be displayed on the white background
    -- end


    
    -- function love.update(dt)
    --     if love.keyboard.isDown("right") then
    --         player.x = player.x + player.speed
    --     end
    
    --     if love.keyboard.isDown("left") then
    --         player.x = player.x - player.speed
    --     end
    
    --     if love.keyboard.isDown("down") then
    --         player.y = player.y + player.speed
    --     end
    
    --     if love.keyboard.isDown("up") then
    --         player.y = player.y - player.speed
    --     end
    -- end
    
    -- function love.draw()
    --     love.graphics.circle("fill", player.x, player.y, 100)
    -- end








-- main.lua

local player1Name = ""
local player2Name = ""
local playerNameInput = ""
local currentPlayer = 1
local bothPlayersEntered = false



local player1Score = 0
local player2Score = 0
local gameState = "start"

function love.load()
    -- Set initial positions and speeds
    player1 = {x = 50, y = love.graphics.getHeight()/2 - 50, speed = 400}
    player2 = {x = love.graphics.getWidth() - 50, y = love.graphics.getHeight()/2 - 50, speed = 400}
    ball = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2, xSpeed = 400, ySpeed = 400}
    
    -- Load sound effects
    bounceSound = love.audio.newSource("music/music.mp3", "static")
    scoreSound = love.audio.newSource("music/music.mp3", "static")

    -- Load music
    love.audio.play(love.audio.newSource("music/music.mp3", "stream"))
end

function love.update(dt)
    if gameState == "play" then
        -- Update player positions
       -- Update player positions
if love.keyboard.isDown("w") and player1.y > 0 then
    player1.y = player1.y - player1.speed * dt
end
if love.keyboard.isDown("z") and player1.y < love.graphics.getHeight() - 100 then
    player1.y = player1.y + player1.speed * dt
end
if love.keyboard.isDown("up") and player2.y > 0 then
    player2.y = player2.y - player2.speed * dt
end
if love.keyboard.isDown("down") and player2.y < love.graphics.getHeight() - 100 then
    player2.y = player2.y + player2.speed * dt
end
        -- Update ball position
        ball.x = ball.x + ball.xSpeed * dt
        ball.y = ball.y + ball.ySpeed * dt

        -- Ball collision with walls
        if ball.y <= 0 or ball.y >= love.graphics.getHeight() then
            ball.ySpeed = -ball.ySpeed
            -- love.audio.play(bounceSound)
        end

        -- Ball collision with players
        if ball.x <= player1.x + 10 and ball.y > player1.y and ball.y < player1.y + 100 then
            ball.xSpeed = -ball.xSpeed
            -- love.audio.play(bounceSound)
        end
        if ball.x >= player2.x - 10 and ball.y > player2.y and ball.y < player2.y + 100 then
            ball.xSpeed = -ball.xSpeed
            -- love.audio.play(bounceSound)
        end

        -- Ball out of bounds
        if ball.x <= 0 then
            player2Score = player2Score + 1
            -- love.audio.play(scoreSound)
            resetBall()
        elseif ball.x >= love.graphics.getWidth() then
            player1Score = player1Score + 1
            -- love.audio.play(scoreSound)
            resetBall()
        end
    elseif gameState == "start" then
        if love.keyboard.isDown("space") then
            gameState = "play"
        end
    end
end

function love.draw()
    -- Draw players and ball
    love.graphics.rectangle("fill", player1.x, player1.y, 10, 100)
    love.graphics.rectangle("fill", player2.x, player2.y, 10, 100)
    love.graphics.circle("fill", ball.x, ball.y, 10)
    
    -- Draw scores
    love.graphics.print("Player 1: " .. player1Score, 20, 20)
    love.graphics.print("Player 2: " .. player2Score, love.graphics.getWidth() - 100, 20)

    -- Draw start message
    if gameState == "start" then
        love.graphics.printf("Press SPACE to start the Game", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
    end
end

function resetBall()
    ball.x = love.graphics.getWidth()/2
    ball.y = love.graphics.getHeight()/2
    ball.xSpeed = -ball.xSpeed
    ball.ySpeed = math.random(-200, 200)
    gameState = "start"
end


