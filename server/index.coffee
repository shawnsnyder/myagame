
coffeemiddleware = require 'connect-coffee-script'
express = require 'express'
midi = require('midi')

path = require 'path'

app = express()
app.enable 'trust proxy'

http = require('http').Server(app);
io = require('socket.io')(http);

io.on 'connection', (socket)->
      console.log('a user connected')

#coffee and js components
app.use '/components', express.static path.join(__dirname, '../bower_components')
app.use '/images', express.static path.join(__dirname, '../src/images')
app.use '/js', coffeemiddleware
    src: "#{__dirname}/../src/scripts"
    dest: "#{__dirname}/../public/js"
    bare: true

app.use express.static(path.join(__dirname, '../public'))

app.get('/', (req, res)->
      res.sendfile('index.html');
)
http.listen(3000, ()->
    console.log('listening on *:3000')
)

#midi section
input = new midi.input()

# Count the available input ports.
input.getPortCount();

# Get the name of a specified input port.
input.getPortName(0);

# Configure a callback.
input.on('message', (deltaTime, message)-> 
  console.log('m:' + message + ' d:' + deltaTime);
  io.emit "midiinput", message
);

# Open the first available input port.
input.openPort(0);
input.ignoreTypes(false, false, false)

#exits
exitHandler = (options, err) ->
  console.log "clean"  if options.cleanup
  console.log err.stack  if err
  process.exit()  if options.exit
  return
process.stdin.resume()

#do something when app is closing
process.on "exit", exitHandler.bind(null,
  cleanup: true
)

#catches ctrl+c event
process.on "SIGINT", exitHandler.bind(null,
  exit: true
)

#catches uncaught exceptions
process.on "uncaughtException", exitHandler.bind(null,
  exit: true
)
