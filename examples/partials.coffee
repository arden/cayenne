express = require 'express'

config = 
  session:express.session(secret: 'hackme')

app 'default', config

def hello: (arg) ->
  console.log express
  console.log arg

helper myhelper: (name) ->
  'hello'

all '/': ->
  @items = [
    {name: 'coffeescript', url: 'http://coffeescript.org'}
    {name: 'ruby', url: 'http://ruby-lang.org'}
    {name: 'python', url: 'http://python.org'}
  ]  
  @hello = myhelper 'hello'   
  puts @id
  puts params.id
  puts session.id
  puts request.sessionID
  render 'default', options: {format: yes}

get '/test': ->
  @items = [
    {name: 'coffeescript', url: 'http://coffeescript.org'}
    {name: 'ruby', url: 'http://ruby-lang.org'}
    {name: 'python', url: 'http://python.org'}
  ]
  puts @id
  render 'default', options: {format: yes}

view ->  
  p -> @hello
  ul ->
    for i in @items
      partial 'item', i: i

view item: ->
  li -> a href: @i.url, -> @i.name








config = 
  session:express.session(secret: 'arden')

app 'test', config


get '/': ->  
  puts session.id
  '3001'