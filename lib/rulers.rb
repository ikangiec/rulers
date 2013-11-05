# require "rulers/array"
# require "rulers/version"

# module Rulers
#   class Application
#     def call(env)
#       `echo debug > debug.txt`; [200, {'Content-Type' => 'text/html'}, ["Hello from Ruby on Rulers!"]]
#     end
#   end
# end

require "rulers/array"
require "rulers/version"
require "rulers/routing"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html', []]
      end
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
      rescue Exception => e
        text = e
      end
      [200, {'Content-Type' => 'text/html'}, [text]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end