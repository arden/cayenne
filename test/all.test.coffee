puts = console.log

soda   = require 'soda'
assert = require 'assert'

{spawn} = require 'child_process'

zappa_a = spawn 'cayenne', ['-p', '4440', 'hi.coffee'], {cwd: 'examples/'}
zappa_b = spawn 'cayenne', ['-p', '4441', 'partials.coffee'], {cwd: 'examples/'}
zappa_c = spawn 'cayenne', ['-p', '4442', 'websockets.coffee'], {cwd: 'examples/'}

# cayenne.stdout.on 'data', (data) ->
#   puts 'stdout: ' + data
# 
# cayenne.stderr.on 'data', (data) ->
#   puts 'stderr: ' + data
# 
# cayenne.on 'exit', (code) ->
#   puts 'cayenne exited with code ' + code

browser = soda.createClient
  host: 'localhost'
  port: 4444
  url: 'http://localhost:4440'
  browser: 'firefox'

browser.on 'command', (cmd, args) ->
  console.log ' \x1b[33m%s\x1b[0m: %s', cmd, args.join(', ')

browser.session (err) ->
  browser.open '/', (err, body) ->
    browser.assertTextPresent 'hi', (error, body) ->
      if error
        console.log 'examples/hi.coffee failed to present text "hi"'
        throw error
      browser.testComplete (err, body) ->
        console.log 'done'

browser_b = soda.createClient
  host: 'localhost'
  port: 4444
  url: 'http://localhost:4441'
  browser: 'firefox'

browser_b.on 'command', (cmd, args) ->
  console.log ' \x1b[33m%s\x1b[0m: %s', cmd, args.join(', ')

browser_b.session (error) ->
  browser_b.open '/', (error, body) ->
    browser_b.assertTextPresent 'coffeescript', (error, body) ->
      throw error if error
    
      browser_b.assertTextPresent 'ruby', (error, body) ->
        throw error if error
      
        browser_b.assertTextPresent 'python', (error, body) ->
          throw error if error
        
          browser_b.testComplete (err, body) ->
            console.log 'done'

browser_c = soda.createClient
  host: 'localhost'
  port: 4444
  url: 'http://localhost:4442'
  browser: 'firefox'

browser_c.on 'command', (cmd, args) ->
  console.log ' \x1b[33m%s\x1b[0m: %s', cmd, args.join(', ')

browser_c.session (error) ->
  browser_c.open '/', (error, body) ->
    browser_c.type 'box', 'ping', (error, body) ->
      browser_c.setTimeout 5000, (error, body) ->
        browser_c.clickAndWait 'say', (err, body) ->
          browser_c.assertTextPresent 'ping', (error, body) ->
            throw error if error

            browser_c.testComplete (err, body) ->
              console.log 'done'
              zappa_a.kill()
              zappa_b.kill()
              zappa_c.kill()