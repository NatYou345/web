FROM ruby:3.4-slim

# Deploying requirements
RUN apt-get update && apt-get install -y \
    rsync \
    openssh-client \
    build-essential \
    libxml2-dev \
    libxslt-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Ruby base template
COPY Gemfile* /app/
COPY vendor/cache /app/vendor/cache
WORKDIR /app

# Install all the dependencies
RUN gem install bundler --version 2.4.22 && bundle install

CMD ["irb"]
