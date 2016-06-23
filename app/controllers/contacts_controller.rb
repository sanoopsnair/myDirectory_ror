class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    require 'net/http'
    @contacts = Contact.all
    respond_with(@contacts)
    response = ''
    # recent_posts = HTTParty.get ""
    response = HTTParty.get('http://bots.meetpipe.com/api/searchhandle?caller=FB')
    # response = HTTParty.get('http://api.stackexchange.com/2.2/questions?site=stackoverflow')
    puts response
    respond_to do |format|
      # msg = { :status => "ok", :message => "Success!", :html => "<b>...</b>" }
      format.json  { render :json => response } # don't do msg.to_json
    end


    # recent_posts.posts.each do |post|
    #   puts post.title #guessing
    # end
  end

  def test
    response = HTTParty.get('http://bots.meetpipe.com/api/searchhandle?caller=FB')
    # puts response
    res = {'re' => response, 'msg' => 'testing'}
    respond_to do |format|
      format.json  { render :json => res } # don't do msg.to_json
    end
  end

  def show
    respond_with(@contact)
  end

  def new
    @contact = Contact.new
    respond_with(@contact)
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    @contact.save
    respond_with(@contact)
  end

  def update
    @contact.update(contact_params)
    respond_with(@contact)
  end

  def destroy
    @contact.destroy
    respond_with(@contact)
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:user_id, :contact_name, :phone_number, :description)
    end
end
