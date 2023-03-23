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
        raw_info.dig("user_info", "hagrid_account_id")
      end

      info do
        {
          name: raw_info.dig("user_info", "name"),
          username: raw_info.dig("user_info", "preferred_username"),
          image: raw_info.dig("user_info", "picture"),
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      # Overrride client to merge in site based on sandbox option
      def client
        # Merge in authorize url if supplied
        options.authorize_params[:clientId] = options.client_id
        options.authorize_params[:redirect] = callback_url
        options.client_options[:authorize_url] = options.authorize_url if options.authorize_url.present?
        options.client_options[:site] = options.site if options.site.present?

        ::OAuth2::Client.new(
          options.client_id,
          options.client_secret,
          deep_symbolize(options.client_options)
        )
      end

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      def raw_info
        return @raw_info if @raw_info

        user_info_url = "https://auth.domain.com.au/v1/connect/userinfo"
        user_info = JSON.parse(access_token.get(user_info_url).body)

        @raw_info ||= {
          "user_info" => user_info || {},
        }
      end
    end
  end
end