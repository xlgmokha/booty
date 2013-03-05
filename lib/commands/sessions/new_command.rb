module Booty
  module Sessions
    class NewCommand
      def initialize(view_engine)
        @view_engine = view_engine
      end
      def run(request)
        [200, "Content-Type" => "text/html" [ @view_engine.render({:template => '/sessions/new.html.erb'})]]
      end
    end
  end
end