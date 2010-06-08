# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_IdoWeb_session',
  :secret      => '1b496d5dcab5e3b71e69acaef7e6cde2c82d12b51afd7694cb3e1fd50c21b255d2fac8ed96f547948f63816c82b22692c3aed34c7711a76becaeba48551e7206'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
