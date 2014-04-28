module Yodlee
  class Config

    class_attribute :username, :password, :register_users, :base_url, :cobrand_session_token_url

    # Load YAML settings
    YAML.load_file("#{Rails.root}/config/yodlee.yml")[Rails.env].each do |key, value|
      self.send("#{key}=", value)
    end

    Yodlee::Base.base_uri base_url

  end
end