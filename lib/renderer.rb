require 'rouge/plugins/redcarpet'

class Renderer < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants
  include Rouge::Plugins::Redcarpet
end
