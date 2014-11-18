require 'open-uri'
require 'json'

class VenuesController < ApplicationController
  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
    @neighborhood = Neighborhood.find(@venue.neighborhood_id)

    url_safe_address = URI.encode(@venue.address)
    url_of_data = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_address}"
    raw_data = open(url_of_data).read
    parsed_data = JSON.parse(raw_data)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
  end

  def new_form
  end

  def create_row
    @venue = Venue.new
    @venue.name = params[:name]
    @venue.address = params[:address]
    @venue.neighborhood_id = params[:neighborhood_id]

    @venue.save

    render('show')
  end

  def edit_form
    @venue = Venue.find(params[:id])
  end

  def update_row
    @venue = Venue.find(params[:id])

    @venue.name = params[:name]
    @venue.address = params[:address]
    @venue.neighborhood_id = params[:neighborhood_id]

    @venue.save

    render('show')
  end

  def destroy
    @venue = Venue.find(params[:id])

    @venue.destroy
  end
end
