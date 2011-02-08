express = require 'express'

config = 
  name: 'default'
  session:express.session(secret: 'hackme')

app(config)

puts = console.log

get '/': ->
  @items = [
    {name: 'coffeescript', url: 'http://coffeescript.org'}
    {name: 'ruby', url: 'http://ruby-lang.org'}
    {name: 'python', url: 'http://python.org'}
  ]
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
  ul ->
    for i in @items
      partial 'item', i: i

view item: ->
  li -> a href: @i.url, -> @i.name

config = 
  name: 'test'

app config