class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    
    # add session
    before_action :initialize_session
    before_action :load_cart
  
    private
  
    def initialize_session
      session[:cart] ||= [] # empty cart = empty array
    end
  
    def load_cart
      @cart = Product.find(session[:cart])
    end



    # def turbo_stream_redirect_to(redirect_url)
    #     render turbo_stream: turbo_stream.append(
    #       :reload,
    #       partial: 'shared/reload_script',
    #       locals: { redirect_url: }
    #     )
    #   end

end
