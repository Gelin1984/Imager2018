 class PinsController < ApplicationController
 before_action :set_pin, only: [:show, :edit, :update,
:destroy]
 before_action :authenticate_user!, except: [:index,
:show]
 before_action :correct_user, only: [:edit, :update,
:destroy]

 def index
 @pins = Pin.all.order("created_at
DESC").paginate(:page => params[:page], :per_page => 3)
 end

def show
 end

 def new
 @pin = current_user.pins.build
 end

def edit
 end

 def create
 @pin = current_user.pins.build(pin_params)

 respond_to do |format|
 if @pin.save
 format.html { redirect_to @pin, notice: 'Pin
successfully created' }
 format.json { render :show, status: :created,
location: @pin }
 else
 format.html { render :new }
 format.json { render json: @pin.errors, status:
:unprocessable_entity }
 end
 end
 end

 def update
 respond_to do |format|
 if @pin.update(pin_params)
 format.html { redirect_to @pin, notice: 'Pin
successsfully updated' }
 format.json { render :show, status: :ok,
location: @pin }
 else
 format.html { render :edit }
 format.json { render json: @pin.errors, status:
:unprocessable_entity }
 end
 end
 end

 def destroy
 @pin.destroy
 respond_to do |format|
 format.html { redirect_to pins_url, notice: 'Pin
successfully destroyed' }
 format.json { head :no_content }
 end
 end

 private
 def set_pin
 @pin = Pin.find(params[:id])
 end

 def pin_params
 params.require(:pin).permit(:description, :image)
 end
 def correct_user
 if @pin.nil?
 @pin = current_user.pins.find_by(id: params[:id])
 redirect_to pins_path, notice: "You are not authorized"

 end
end
end
