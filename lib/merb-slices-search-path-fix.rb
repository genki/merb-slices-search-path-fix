# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_slices_search_path_fix] = {
    :chickens => false
  }
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
    require 'merb-slices-search-path-fix/merb_slices_fix'
  end
  
  Merb::BootLoader.after_app_loads do
    # code that can be required after the application loads
  end
  
  Merb::Plugins.add_rakefiles "merb-slices-search-path-fix/merbtasks"
end
