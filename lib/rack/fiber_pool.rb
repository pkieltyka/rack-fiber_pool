require 'fiber_pool'

module Rack

  # Run each request in a Fiber.  This FiberPool is provided by em_postgresql.
  class FiberPool
    ASYNC_RESPONSE = [-1, {}, []].freeze
    
    def initialize(app)
      @app = app
      @fiber_pool = ::FiberPool.new
      yield @fiber_pool if block_given?
    end
    
    def call(env)
      call_app = lambda do
        result = @app.call(env)
        
        # Check if it's an async app wrapped in a fiber
        if result == ASYNC_RESPONSE
          f = Fiber.current
          env['async.close'].callback { f.resume }
          Fiber.yield
        else
          env['async.callback'].call result
        end
      end
      
      @fiber_pool.spawn(&call_app)
      
      ASYNC_RESPONSE
    end
  end
end
