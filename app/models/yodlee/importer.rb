module Yodlee
  class Importer < Base

    def content_services *type
      #type allowed: :all, OR specific type(s), :bank, :credits, :miles, :loans, etc.
      all_content_services.each do |bank|
        container = bank.containerInfo.containerName.to_sym
        next unless Array(type).include?(container) || type == :all

        mfa = bank.key?('mfaType') ? bank.mfaType.typeName : 'none'

        row = ::Bank.where(content_service_id: bank.contentServiceId).first_or_create
        row.update_attributes!(
          content_service_id:           bank.contentServiceId,
          url_home:                     bank.homeUrl,
          content_service_display_name: bank.contentServiceDisplayName,
          site_id:                      bank.siteId,
          site_display_name:            bank.siteDisplayName,
          container:                    container,
          mfa:                          mfa
        )
      end
    end



    private

    def all_content_services
      query({
        endpoint: Yodlee::Config.url_get_all_content_services,
        method: :POST,
        params: {
          cobSessionToken: cobrand_token,
          notrim: true
        }
      })
    end

  end
end