Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['7rXkBO6LHxvLKKvHQQGYFvgqs'], ENV['xXJKVxZordz6rOwSuRLakFyBL6xgwEfu6NocNOh9h6X77c2mC4']
end