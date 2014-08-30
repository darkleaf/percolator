module ElasticStorage
  module Settings
    extend self

    def settings
      {
        analysis: {
          filter: {
            en_stop_filter: {
              type: :stop,
              stopwords: '_english_'
            },
            en_stem_filter: {
              type: 'stemmer',
              name: 'minimal_english'
            },
            ru_stop_filter: {
              type: 'stop',
              stopwords: '_russian_'
            },
            ru_stem_filter: {
              type: 'stemmer',
              name: 'light_russian'
            },
          },
          analyzer: {
            default: {
              type: :custom,
              tokenizer: 'icu_tokenizer',
              filter: %w[icu_normalizer ru_stop_filter en_stop_filter ru_stem_filter en_stem_filter icu_folding],
            },
          }
        }
      }
    end

    def mappings
      {
        post: {
          properties: {
            title: { type: :string },
            content: { type: :string },
            published_at: { type: :date },
          }
        }
      }
    end
  end
end