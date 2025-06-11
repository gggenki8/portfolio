class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    missing = %i[name email body].select { |k| contact_params[k].blank? }

    if missing.any?
      @contact = Contact.new(contact_params)
      labels = { name: "お名前", email: "メールアドレス", body: "お問い合わせ内容" }
      flash.now[:alert] = missing.map { |k| labels[k] }.join("、") + "を入力してください。"
      render :new
    else
      redirect_to new_contact_path, notice: "お問い合わせありがとうございます。"
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :body)
  end
end
