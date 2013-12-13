require "suretax/version"
require "suretax/configuration"


module Suretax

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Suretax::Configuration.new
    yield(configuration)
  end
end
