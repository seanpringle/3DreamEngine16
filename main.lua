require('util')

local dream = require('3DreamEngine')

function love.load()

  love.window.setMode(1280,720,{vsync = -1})

  dream.msaa = 16
  dream.bloom_enabled = false
  dream.secondPass = true
  dream.deferred_lighting = true
  dream.shadow_factor = 4
  dream.shadow_resolution = dream.shadow_resolution*2
  dream.shadow_cube_resolution = dream.shadow_cube_resolution*2
  dream.shadow_distance = 10
  dream.sky_enabled = false
  dream.sun = vec3(-0.5,1,0)
  dream.sun_color = vec3(2.0, 2.0, 2.0)
  dream.sun_ambient = vec3(0.5, 0.5, 0.5)

  dream.cam.fov = 45
  dream.cam.eye = vec3(0,15,5)
  dream.cam.target = vec3(0,0,0)

  dream:init()

  container = dream:loadObject('shipping-container', {splitMaterials = true})
  platform = dream:loadObject('platform', {splitMaterials = true})
end

function love.draw()
  dream:resetLight()
  dream:prepare()
  dream.cam:reset()
  dream.cam.transform = dream:lookAt(dream.cam.eye, dream.cam.target)
  dream:draw(container, 0, 1, 0)
  dream:draw(platform, 0, -0.5, 0)
  dream:present()
end

function love.mousemoved(x, y, dx, dy)
  mouseX = x
  mouseY = y

  local speedH = 0.005
  local speedV = 0.005
  local ex = dream.cam.eye[1]
  local ey = dream.cam.eye[2]
  local ez = dream.cam.eye[3]
  local rH = math.abs(speedH*dx)
  local rV = math.abs(speedH*dy)
  local signH = dx < 0 and -1 or 1
  local signV = dy < 0 and -1 or 1

  if love.mouse.isDown(2) then
    dream.cam.eye[1] = ex * math.cos(rH) + (ez * math.sin(rH) * -signH)
    dream.cam.eye[3] = ez * math.cos(rH) + (ex * math.sin(rH) *  signH)

    ez = dream.cam.eye[3]

    dream.cam.eye[2] = ey * math.cos(rV) + (ez * math.sin(rV) *  signV)
    dream.cam.eye[3] = ez * math.cos(rV) + (ey * math.sin(rV) * -signV)
  end
end

function love.wheelmoved(x, y)
  local eye = dream.cam.eye
  local norm = eye:normalize()
  dream.cam.eye = y < 0 and (eye + norm) or (eye - norm)
end