require "uri"
require "net/http"

class Base
  include ActiveModel::Model
  include Cacheable

  def self.profile_request(url, query_params = {})
    Rails.cache.fetch("profile-req-#{url}", expires_in: default_cache_time, skip_nil: true) do
      sr = WmsResource::SecureRequest.new("profile")

      uri = URI(url)
      uri.query = URI.encode_www_form(query_params.merge(sr_hash: sr.generate_hash, sr_timestamp: sr.timestamp))

      res = Net::HTTP.get_response(uri)

      JSON.parse(res.body, symbolize_names: true)
    end
  end
end
