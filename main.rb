# frozen_string_literal: true

require 'rubygems'
require 'gosu'
require 'rmagick'
require 'httparty'

class Rando < Gosu::Window
	def initialize
		super 1024, 1024

		@generate_url = "https://this-person-does-not-exist.com/en?new"
		@image_url = "https://this-person-does-not-exist.com/%s"
	end

	def update
		puts "Getting new image"
		get_image
	end

	def draw
		@img&.draw 0, 0, 0, 1.0, 1.0
	end

	def get_image
		new_image = HTTParty.get @generate_url
		blob = (HTTParty.get format(@image_url, new_image["src"])).body
		@img = Gosu::Image.new (Magick::Image.from_blob blob).first
	end
end

Rando.new.show
