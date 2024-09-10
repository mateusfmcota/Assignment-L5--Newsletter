class UserMailer < ApplicationMailer
  def hello
    @user = params[:user]
    attachments["flower.png"] = File.read("/home/cota/Área de trabalho/Captura de imagem_20240523_134322.png")
    mail(to: email_address_with_name(@user.email, @user.name), subject: "Hello #{@user.name}")
  end
end
