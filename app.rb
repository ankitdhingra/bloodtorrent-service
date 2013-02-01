require 'sinatra'
require 'json'
require 'mongoid'
Dir["models/**/*.rb"].sort.each {|file| require_relative file}
Mongoid.load!("./config/mongoid.yml")

get '/donation/new' do
  blood_group = params[:blood_group]
  latitude = params[:latitude]
  longitude = params[:longitude]
  quantity = params[:quantity]
  requestor_name = params[:requestor]
  contact_details = params[:contact_details]


  request = DonationRequest.new(:blood_group => blood_group,
                                :coordinates => [longitude,latitude],
                                :quantity => quantity,
                                :requestor => requestor_name,
                                :contact_details => contact_details)

  request.save!
end

get '/donation/search' do
  blood_group = params[:blood_group]
  latitude = params[:latitude]
  longitude = params[:longitude]
  radius = params[:radius]

  requests = DonationRequest.where(:blood_group => blood_group)

  content_type :json
  requests.to_json
end

get '/' do
  "Dragons be here"
end
