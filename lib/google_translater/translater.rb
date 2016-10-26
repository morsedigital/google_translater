require 'net/http'

# Translater
class Translater # rubocop:disable Metrics/ClassLength
  class << self
    attr_reader :from_language
    attr_reader :input
    attr_reader :to_language

    def google_base_url
      'https://translate.googleapis.com/translate_a/single'
    end

    def google_params
      "client=gtx&sl=#{from_language}&tl=#{to_language}&dt=t&q=#{input}"
    end

    def google_response
      uri = URI google_url
      Net::HTTP.get_response uri
    end

    def google_url
      [google_base_url, google_params].join('?')
    end

    def languages_match?
      to_language == from_language
    end

    def parsed_google_response
      google_response.body.gsub(/\[|\]|"/, '').split(',').first.force_encoding('UTF-8')
    end

    def recognized?(language)
      language_map.key?(language)
    end

    def translate(input, from_language, to_language)
      @input = input
      @from_language = from_language.to_sym
      @to_language = to_language.to_sym
      return input if languages_match?
      return unknown_languages_message if unknown_languages?
      translated_input
    end

    def translated_input
      parsed_google_response
    end

    def unknown_languages?
      return false if recognized?(from_language) && recognized?(to_language)
      result = recognized?(from_language) ? [] : [from_language]
      result << to_language unless recognized?(to_language)
    end

    def unknown_languages_message
      "I don't recognize #{unknown_languages.join(' or ')}"
    end

    # Putting this at the bottom to keep it out of the way
    def language_map # rubocop:disable Metrics/MethodLength
      {
        :af => 'Afrikaans',
        :sq => 'Albanian',
        :ar => 'Arabic',
        :az => 'Azerbaijani',
        :eu => 'Basque',
        :bn => 'Bengali',
        :be => 'Belarusian',
        :bg => 'Bulgarian',
        :ca => 'Catalan',
        :'zh-CN' => 'Chinese Simplified',
        :'zh-TW' => 'Chinese Traditional',
        :hr => 'Croatian',
        :cs => 'Czech',
        :da => 'Danish',
        :nl => 'Dutch',
        :en => 'English',
        :eo => 'Esperanto',
        :et => 'Estonian',
        :tl => 'Filipino',
        :fi => 'Finnish',
        :fr => 'French',
        :gl => 'Galician',
        :ka => 'Georgian',
        :de => 'German',
        :el => 'Greek',
        :gu => 'Gujarati',
        :ht => 'Haitian Creole',
        :iw => 'Hebrew',
        :hi => 'Hindi',
        :hu => 'Hungarian',
        :is => 'Icelandic',
        :id => 'Indonesian',
        :ga => 'Irish',
        :it => 'Italian',
        :ja => 'Japanese',
        :kn => 'Kannada',
        :ko => 'Korean',
        :la => 'Latin',
        :lv => 'Latvian',
        :lt => 'Lithuanian',
        :mk => 'Macedonian',
        :ms => 'Malay',
        :mt => 'Maltese',
        :no => 'Norwegian',
        :fa => 'Persian',
        :pl => 'Polish',
        :pt => 'Portuguese',
        :ro => 'Romanian',
        :ru => 'Russian',
        :sr => 'Serbian',
        :sk => 'Slovak',
        :sl => 'Slovenian',
        :es => 'Spanish',
        :sw => 'Swahili',
        :sv => 'Swedish',
        :ta => 'Tamil',
        :te => 'Telugu',
        :th => 'Thai',
        :tr => 'Turkish',
        :uk => 'Ukrainian',
        :ur => 'Urdu',
        :vi => 'Vietnamese',
        :cy => 'Welsh',
        :yi => 'Yiddish'
      }
    end
  end
end
