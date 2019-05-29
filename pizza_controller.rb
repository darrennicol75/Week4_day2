require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('./models/pizza_order')
also_reload('./models/*')

# INDEX- display all pizzas (GET request)

get '/pizza-orders' do
  @orders = PizzaOrder.all()
  erb(:index)
end
# The below determines what to do if pizza orders is typed into the browser bar.

# NEW- display a form to make a new pizza order
# watch for naming convention, new wouldn't work after :id
# so move before.

get '/pizza-orders/new' do
  erb(:new)
end

# CREATE- create a database entry for new pizza order
post '/pizza-orders' do
  # binding.pry
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

# DELETE- deletes a pizza order from the database.
post '/pizza-orders/:id/delete' do
 @order = PizzaOrder.find(params[:id])
 @order.delete()
 erb(:delete)
 # redirect to '/pizza-orders'
end
# If using the redirect drop the @'s from the order.
  # erb(:delete)

# EDIT- display a form to edit a pizza orders details
get '/pizza-orders/:id/edit' do
  order = PizzaOrder.find( params[:id] )
  erb(:edit)
end
# UPDATE- updates a database entry for the edited pizza order
post '/pizza-orders/:id/edit' do
  order =PizzaOrder.new(params)
  order.update()
  redirect to '/pizza-orders'
end

# SHOW- display one pizza
# /:id is a show command for id's
get '/pizza-orders/:id' do
  @order =PizzaOrder.find(params[:id])
  erb(:show)
end
# remember you can use a binding.pry to check for errors.
