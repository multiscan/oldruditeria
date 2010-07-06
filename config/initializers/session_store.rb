# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ruditeria_session',
  :secret      => 'f299a629e9a2e546c31c0c2a6dfa54ed80027f2a8250c28218a6f837d52657124e0ecb500fb7b9536d25fed66a74e10a0c5cca65da6507e81aa2ef4b949773d0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
