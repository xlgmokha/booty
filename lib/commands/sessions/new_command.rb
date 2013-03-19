module Booty
  module Sessions
    class NewCommand < RouteCommand
      handles :uri => /^\/sessions\/new$/, :method => :GET

      def initialize(view_engine)
        @view_engine = view_engine
      end
      def run(request)
        HtmlResponse.new(:template => '/sessions/new.html.erb').run(@view_engine)
      end
    end
  end
end
