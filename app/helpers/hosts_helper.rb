module HostsHelper
  def gravatar_for(host, options = { :size => 50 })
      gravatar_image_tag(host.email.downcase, :alt => h(host.first_name),
                                              :class => 'gravatar',
                                              :gravatar => options)
    end
end
