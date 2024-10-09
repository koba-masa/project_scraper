.PHONY: install, test, lint, format, bash, run

install:
	docker compose run --rm app bundle install

test:
	docker compose run --rm app bundle exec rspec

lint:
	docker compose run --rm app bundle exec rubocop

format:
	docker compose run --rm app bundle exec rubocop -A

bash:
	docker compose run --rm app bash --login

run:
	docker compose run --rm app bundle exec ruby main.rb
