include 'define.coffee'

class Test
    hello: ->
        express = require 'express'
        console.log express
        console.log 'hello'
    
def mytest:(arg) ->
    console.log arg
    console.log require 'express'
    console.log 'aaaaaaaaaa'
    a = new Test()
    a.hello()
    console.log a
    
def express: require 'express'

def thetest: new Test().hello

def zig: -> 'zag'

get '/': ->
    mytest('sssssss')
    render 'test', options: {format: yes}

get '/test': ->
    @format = 'yes'
    @items = [
        {name: 'coffeescript', url: 'http://coffeescript.org'}
        {name: 'ruby', url: 'http://ruby-lang.org'}
        {name: 'python', url: 'http://python.org'}
    ]
    puts @items
    puts @format
    render 'default', options: {format: @format}



include 'views/test.coffee'

app 'test'