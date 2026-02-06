# frozen_string_literal: true

class HomesController < ApplicationController
  def index; end

  def countries_list
    gulf_countries = %w[SA KW AE QA BH OM IQ]
    countries = ISO3166::Country.all&.map { |c| { country_name: c.common_name, country_code: c.country_code, country_flag: c.emoji_flag, short_name: c.alpha2, number_lengths: c.national_number_lengths } }
    country_hash = countries.index_by { |country| country[:short_name] }
    gulf_countries_list = gulf_countries.map { |code| country_hash[code] }.compact
    countries_list = gulf_countries_list + (countries - gulf_countries_list)
    render json: { countries: countries_list }, status: :ok
  end

  def cities_list
    country = ISO3166::Country.find_country_by_alpha2('IN')
    return render json: { cities: [] }, status: :ok unless country

    states = extract_states(country)
    cities = states.map { |state| CS.cities(state, 'IN') }.compact_blank.flatten

    render json: { cities: cities }, status: :ok
  end

  private

  def extract_states(country)
    country.subdivisions&.map { |_, sub| sub.code }&.reject(&:blank?)&.flatten || []
  end
end
