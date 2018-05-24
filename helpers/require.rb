require 'yaml'
module Require
  def self.require_all _dir
    Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each do |file|
      require_relative file
    end
  end
end
