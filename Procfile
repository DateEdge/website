web: bundle exec puma -t 0:10 -p $PORT
worker: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7 bundle exec rake resque:work QUEUE=*

