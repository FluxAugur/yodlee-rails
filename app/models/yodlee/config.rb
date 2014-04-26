module Yodlee
  class Config

    class_attribute :username, :password, :base_url, :register_users

    # Load YAML settings
    YAML.load_file("#{Rails.root}/config/yodlee.yml")[Rails.env].each do |key, value|
      self.senc("#{key}=", value)
    end

    Yodlee::Base.base_url base_url

  end
end