[![Build Status](https://travis-ci.org/darkleaf/percolator.svg)](https://travis-ci.org/darkleaf/percolator)
[![Code Climate](https://codeclimate.com/github/darkleaf/percolator/badges/gpa.svg)](https://codeclimate.com/github/darkleaf/percolator)
[![Test Coverage](https://codeclimate.com/github/darkleaf/percolator/badges/coverage.svg)](https://codeclimate.com/github/darkleaf/percolator)


download elasticsearch in elasticsearch folder

# Elasticsearch test config
    cluster.name: elasticsearch-test
    transport.tcp.port: 9301
    http.port: 9201
    index.number_of_shards: 1
    index.number_of_replicas: 0

# Heroku

    heroku apps:create YOU_NICK_NAME-percolator
    heroku addons:add bonsai
    #remove postgresql addon ?

    heroku config:set PASSWORD=YOU_PASSWORD
    heroku config:set API_KEY=YOU_API_KEY

    g push heroku master
