class ContactsController < ApplicationController
	
	def index
    @contacts = Contact.all.order(created_at: :asc)
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save  
      redirect_to @contact
    else
      redirect_to new_contact_path
    end
  end

  # def edit
  #   @contact = Contact.find(params[:id])
  # end

  # def update
  #   @contact = Contact.find(params[:id])

  #   if @contact.update(contact_params)
  #   	# flash[:alert] = "Updates Successfully!!!"
  #     redirect_to @contact
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   @contact = Contact.find(params[:id])
  #   @contact.destroy

  #   redirect_to root_path, status: :see_other
  # end

  private
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :address, :suggetion)
    end
end
