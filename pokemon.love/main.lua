--[[


    This proof of concept demonstrates basic GUI usage, random encounters, creatures that the
    player can fight and catch with their own creatures, and basic NPC interaction in the form of
    very simple dialogue.

    Credit for art:
    Buch - https://opengameart.org/users/buch (tile sprites)

    Monster sprites:
    http://creativecommons.org/licenses/by-sa/4.0/
        Aardart - Magic-Purple-Hermit
            https://wiki.tuxemon.org/index.php?title=Magic-Purple-Hermit
        Agnite - Leo, Sanglorian, and extyrannomon
            https://wiki.tuxemon.org/index.php?title=Leo
            https://wiki.tuxemon.org/index.php?title=Sanglorian
            https://wiki.tuxemon.org/index.php?title=Extyrannomon&action=edit&redlink=1
        Anoleaf - Spalding004
            https://wiki.tuxemon.org/index.php?title=Spalding004
        Bamboon - Mike Bramson
            mnbramson@gmail.com
        Cardiwing - Spalding004
            https://wiki.tuxemon.org/index.php?title=Spalding004

    Credit for music:
    Field: https://freesound.org/people/Mrthenoronha/sounds/371843/
    Battle: https://freesound.org/people/Sirkoto51/sounds/414214/
]]

require 'src/Dependencies'

function love.load()
    love.window.setTitle('Poke50')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    -- this time, we are using a stack for all of our states, where the field state is the
    -- foundational state; it will have its behavior preserved between state changes because
    -- it is essentially being placed "behind" other running states as needed (like the battle
    -- state)

    gStateStack = StateStack()
    gStateStack:push(StartState())

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end
