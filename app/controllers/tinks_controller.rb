class TinksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tinks = current_user.tinks

    respond_to do |format|
      format.html #index.html.erb
    end
  end

  def new
  	@tink = Tink.new
    @tink.title = params[:title]
    @tink.url = params[:url]

  	respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tink }
    end
  end

  def create
    require 'open-uri'
    @tink = Tink.new
    #@tink = Tink.new(params[:tink])
    @tink.url = params[:tink][:url]
    @tink.receiver = params[:tink][:receiver]
    @tink.user = current_user

    #if @tink.receiver == '1'
     # did = '5B3275894AEB9D7E9693EBD33105B54ECCA8CE4CB7EC11D846B47FCCC0607EEB'
    #else
     # did = 'F421EC8F0AA6D1FE4B9286C04A48168A12512AD9AB669A78DC36C61D708AE2F5'
    #end

    did = current_user.device_id

    #@tink.user_id

    title = Nokogiri::HTML(open(@tink.url)).title()

    Bitly.use_api_version_3

    bitly = Bitly.new('fleetcreations', 'R_77619b7f25394f4f4790e4455249832e')
    u = bitly.shorten(@tink.url)

    notification = {
      :device_tokens => [did],
      :aps => {:alert => "#{title} #{u.short_url}", :badge => 1}
    }



  	respond_to do |format|
  		if @tink.save
        Urbanairship.push(notification)
  			
        format.html { redirect_to @tink, notice: "Tink was successfully created and sent."}
  			format.json { render json: @user, status: :created, location: @tink }
  		else
  			format.html { render action: "new"}
  			format.json { redner json: @tink.errors, status: :unprocessable_entity }
  		end
  	end
  end

  def show
  	@tink = Tink.find(params[:id])

  	respond_to do |format|
  		format.html #show.html.erb
  		format.json { render json: @tink }
  	end
  end

    protected

    def set_cache_buster
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
end
