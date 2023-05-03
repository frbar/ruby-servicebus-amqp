FROM ruby:2.5-alpine
RUN apk update && apk add --virtual build-dependencies build-base
WORKDIR /var/www/ruby
COPY Gemfile /var/www/ruby
RUN bundle install
COPY . /var/www/ruby
CMD ["ruby", "amqpclient.rb"]
#CMD ["ruby", "bunny.rb"]
