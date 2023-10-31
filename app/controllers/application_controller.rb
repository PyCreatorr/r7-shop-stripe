class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    # def turbo_stream_redirect_to(redirect_url)
    #     render turbo_stream: turbo_stream.append(
    #       :reload,
    #       partial: 'shared/reload_script',
    #       locals: { redirect_url: }
    #     )
    #   end

end
