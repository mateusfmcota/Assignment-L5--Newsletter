class EmailsController < ApplicationController
  before_action :get_templates
  def index
    @emails = Email.all
  end

  def new
    @email = Email.new
  end

  def create
    @email = Email.new(subject: email_params[:subject], body: email_params[:body])
    @template = Template.find_by(email_params[:template])

    @email.body = @template.body.gsub("{{placeholder}}", @email.body) if @template.present?

    if @email.save
      Subscriber.all.each do |subscriber|
        NewsletterMailer.email(subscriber, @email).deliver_now
      end
      redirect_to emails_path, notice: "Email Sent"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @email = Email.find(params[:id])
  end

  private

    def email_params
      params.require(:email).permit(:subject, :body, :template)
    end

  def get_templates
    @templates = Template.all
  end
end
