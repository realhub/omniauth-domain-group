require 'omniauth/strategies/oauth2'

# Potential scopes: https://developer.domain.com.au/docs/media/public-adapter-v1.json
# securityDefinitions
# ------
# openid
# profile
# offline_access (required for refresh token)
# api_addresslocators_read
# api_agencies_read
# api_agencies_write
# api_demographics_read
# api_disclaimers_read
# api_enquiries_read
# api_enquiries_write
# api_listings_read
# api_listings_write
# api_locations_read
# api_properties_read
# api_propertyreports_read
# api_salesresults_read
# api_statistics_write
# api_suburbperformance_read
# api_webhooks_write
#
# Separate scopes with a space (%20)

module OmniAuth
  module Strategies
    class DomainGroup < OmniAuth::Strategies::OAuth2
      option :name, 'domain_group'

      option :client_options,
             site: 'https://auth.domain.com.au',
             authorize_url: 'https://auth.domain.com.au/v1/connect/authorize',
             token_url: 'https://auth.domain.com.au/v1/connect/token',
             audience: 'api.domain.com.au'

      uid do
        "fakeID"
      end

      info do
        {
          name: "Fake Name",
          email: "Fake Email",
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      def raw_info
        return @raw_info if @raw_info

        @raw_info ||= {}
      end
    end
  end
end