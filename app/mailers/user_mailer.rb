class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "WeeklyWack - Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "WeeklyWack - Password reset"
  end
end
