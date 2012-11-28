class RegistrationsController < Devise::RegistrationsController

  # override #create to respond to AJAX with a partial
  def create
    build_resource
    resource.opt_in_ip = request.headers["HTTP_CF_CONNECTING_IP"] || request.remote_ip
    if resource.save
      if resource.active_for_authentication?
        sign_in(resource_name, resource)
        if request.xhr?
          render :js => "window.location = '#{after_sign_up_path_for(resource)}'"
        else
          respond_with resource, :location => after_sign_up_path_for(resource)
        end
      else
        expire_session_data_after_sign_in!
        if request.xhr?
          render :js => "window.location = '#{after_inactive_sign_up_path_for(resource)}'"
        else
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      end
    else
      clean_up_passwords resource
      render :action => :new, :layout => !request.xhr?
    end
  end
  
  def thanks
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    thanks_path
  end

  def after_sign_up_path_for(resource)
    # the page new users will see after sign up (after launch, when no invitation is needed)
    root_path
  end

end
