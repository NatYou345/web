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
WORKDIR /app

# Install Bundler v2 and all dependencies
# BUNDLE_IGNORE_MESSAGES suppresses bundler version warnings from old gems
ENV BUNDLE_SILENCE_DEPRECATIONS=true
RUN gem install bundler --version 2.4.22 && \
    bundle config set --local deployment 'false' && \
    bundle install

CMD ["irb"]
