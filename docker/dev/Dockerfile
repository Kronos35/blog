FROM ruby:3.0

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock
RUN BUNDLE_JOBS=4 bundle install
COPY . /usr/src/app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Install nodejs
RUN apt -qq update && apt -q -y install libv8-dev && apt -q -y install nodejs
RUN apt -y install npm

# Install yarn
RUN npm install -y --global yarn

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
