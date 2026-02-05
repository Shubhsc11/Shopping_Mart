class HomesController < ApplicationController
  def index
  end

  def countries_list
    gulf_countries = ['SA', 'KW', 'AE', 'QA', 'BH', 'OM', 'IQ']
    countries = ISO3166::Country.all&.map { |c| { country_name: c.common_name, country_code: c.country_code, country_flag: c.emoji_flag, short_name: c.alpha2, number_lengths: c.national_number_lengths } }
    country_hash = countries.index_by { |country| country[:short_name] }
    gulf_countries_list = gulf_countries.map { |code| country_hash[code] }.compact
    countries_list = gulf_countries_list + (countries - gulf_countries_list)
    render json: { countries: countries_list }, status: :ok
  end

  def cities_list
    c = ISO3166::Country.find_country_by_alpha2('IN')
    states = c&.subdivisions&.map { |_, sub| sub.code }.reject(&:blank?).flatten
    cities = []
    states.each do |state|
      cities << CS.cities(state, 'IN')
    end
    render json: { cities: cities.reject(&:blank?).flatten }, status: :ok
  end
end
