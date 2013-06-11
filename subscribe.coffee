#!/usr/bin/env coffee

# Require libraries
{MailChimpAPI} = require 'mailchimp'

# Constants
{API_KEY, LIST_ID} = process.env
throw new Error 'Credentials unavailable.' if not API_KEY and LIST_ID

# Helpers.
pp = (obj) -> JSON.stringify obj, null, 4

# Exports.
module.exports = (email, cb) ->
  api = new MailChimpAPI API_KEY,
    version: '1.3'
    secure: false

  api.listSubscribe {
    id: LIST_ID
    email_address: email
  }, (e, data) ->
    console.log e, data

    response = [
      if e?.code is 200 then e else null
      if not e then 'success' else 'subscribed' if e?.code is 214
    ]
    cb response...
