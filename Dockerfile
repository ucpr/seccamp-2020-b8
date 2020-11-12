FROM ruby:2.6.3

RUN apt update -y && apt install -y --no-install-recommends libpq-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /application

COPY . .

RUN bundle install

EXPOSE 3000

CMD ["rails", "server"]
