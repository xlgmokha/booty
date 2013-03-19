require 'component'

module Booty
  class Container
    def initialize
      @items = {}
      register(:container) { self }
    end
    def register(key, &block)
      component = Component.new(key, &block)
      components_for(key).push(component)
      component
    end
    def resolve(key)
      instantiate(components_for(key).first)
    end
    def resolve_all(key)
      components_for(key).map {|item| instantiate(item) }
    end
    def build(type)
      try("I could not create: #{type}"){ build!(type) }
    end
    def build!(type)
      constructor = type.instance_method('initialize')
      parameters = constructor.parameters.map do |req, parameter|
        #logger.info("attempting to resolve #{parameter}")
        resolve(parameter.to_sym)
      end
      type.send(:new, *parameters)
    end

    private

    def components_for(key)
      @items[key] = [] unless @items[key]
      @items[key]
    end
    def instantiate(component)
      component.create(self)
    end
    def try(error = nil, &lambda)
      begin
        lambda.call
      rescue => e
        error ||= "Oops: #{e}"
        logger.error(error)
        nil
      end
    end
  end
end