#!/usr/bin/env coffee

# Require libraries
restify = require 'restify'
subscribe = require './subscribe'

# Init REST server.
server = restify.createServer
  name: 'mailchimp-adder'
  version: '0.1.0'

# Add middleware.
server.use restify.jsonp()
server.use restify.acceptParser server.acceptable
server.use restify.queryParser()
server.use restify.bodyParser()

# Routes
server.get '/subscribe', (req, res, next) ->
  subscribe (req.email or req.query?.email), (e, status) ->
    response = if e then [500, status: 'error'] else [200, status: status]
    res.send response...

    next()

# Start server.
port = process.env.PORT or 5000
server.listen port, ->
  console.log "Server listening on port: #{ port }"
