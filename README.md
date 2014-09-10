[![Build Status](https://travis-ci.org/darkleaf/percolator.svg)](https://travis-ci.org/darkleaf/percolator)
[![Code Climate](https://codeclimate.com/github/darkleaf/percolator/badges/gpa.svg)](https://codeclimate.com/github/darkleaf/percolator)
[![Test Coverage](https://codeclimate.com/github/darkleaf/percolator/badges/coverage.svg)](https://codeclimate.com/github/darkleaf/percolator)


download elasticsearch in elasticsearch folder


# Elasticsearch plugins

    elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-icu/2.3.0


# Elasticsearch test config
    cluster.name: elasticsearch-test
    transport.tcp.port: 9301
    http.port: 9201
    index.number_of_shards: 1
    index.number_of_replicas: 0

# Heroku

    heroku apps:create YOU_NICK_NAME-percolator
    heroku addons:add bonsai
    heroku addons:add newrelic:stark
    #remove postgresql addon ?

    heroku config:set PASSWORD=YOU_PASSWORD
    heroku config:set API_KEY=YOU_API_KEY
    heroku config:set GOOGLE_ANALYTICS=UA-xxxxxx-x
    heroku config:set DISQUS_SHORTNAME=SOME_NAME

    g push heroku master
