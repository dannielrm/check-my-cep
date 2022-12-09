# Challenge for Backend - Ruby on Rails

This is a rails API to receive a JSON payload and retrieve the address from ViaCEP API.
I integrated the API with a very simple React frontend to view the data that was inserted.
The original plan was to allow the frontend to submit a form with JSON content to the API, but I missed something to make the request the same as we can send via CORS and it's not working. I left it there (broken) to show the effort that I put into it.
The main challenge was that the JSON available as an example is not a valid one, so I had to patch ActionDispatch middleware to make up for the parsing errors.

## Setup instructions:
- Install Ruby 2.7.5 and Rails 7.04 using your desired version manager (eg. rvm)
https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rvm-on-ubuntu-18-04

- Install and configure Postgres
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04

- Install Redis
https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04

- Install NodeJS
https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04

- Navigate to project folder and `bundle`
- With Postgres already running: `rails db:create db:migrate db:seed`
- Navigate to the frontend namespace and `npm install`

## Run instructions:
- For the frontend, navigate to the frontend namespace inside the project and: `npm start`
- You can start the whole backend using foreman with: `foreman start -f Procfile.dev -p 3000`
- Alternatively in separate shells you can:
-- Start Redis with: `redis-server`
-- Start Sidekiq with: `sidekiq start`
-- Start Rails with: `Rails s`
- You can also run some simple tests for the backend with `rspec`

## Usage
- As mentioned previously, the input is not working properly and the frontend is basically to view data. This project was made considering primarily API requests to the backend so that was the priority.
- I recommend using Postman or Insomnia to make the requests necessary to use this API.
- To view data, simply request or use your browser to go to `http://localhost:3000/api/customers`
- To insert data, you can use Postman and create a POST request to `http://localhost:3000/api/customers` with body `raw` as `JSON` and use the given `customers.json`
-- Also, here's a curl request to use as an example: `curl -d '[{"cep": 1001000,"name": "JOSE"}, {"cep": 1001900,"name": "FRANCISCO"}, {"cep": 99999999,"name": "ERRADO"}]' http://localhost:3000/api/customers --header "Accept: application/json" --header "Content-Type: application/json"`
- You can also delete entries by passing a DELETE request to `http://localhost:3000/api/customers/<id>`

## Personal Note
This isn't my proudest work, and some seemingly small issues turned out a lot more complicated to solve, like the JSON thing. That being said, I believe I was able to work around a lot of the challenges, but having more time I'd improve the project in several areas, starting by fixing the imput, creating a whole lot more specs and giving better visual feedback when using the UI.
I hope we can talk about this project and your thoughts on it. Thanks!