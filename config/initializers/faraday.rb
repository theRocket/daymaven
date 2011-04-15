require 'faraday'
module Faraday 
  class Adapter < Middleware
    def call(env)
      env[:ssl][:verify] = false if env[:ssl]
      process_body_for_request(env)
    end
  end
end
