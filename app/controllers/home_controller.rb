class HomeController < ApplicationController
  def index
    if !user_signed_in?
      cookies.delete("rainy-days", {
        value: "",
        expires: 10.years.ago,
        path: "/",
        httponly: false
      })
    end
  end

  private
  def user_signed_in?
    session[:email] && session[:email].length >= 3
  end
end
