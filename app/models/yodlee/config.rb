module Yodlee
  class Config

    class_attribute :username, :password, :register_users, :url_base, :url_cobrand_session_token, :url_get_all_content_services

    # Load YAML settings
    YAML.load_file("#{Rails.root}/config/yodlee.yml")[Rails.env].each do |key, value|
      self.send("#{key}=", value)
    end

    Yodlee::Base.base_uri url_base

  end
end