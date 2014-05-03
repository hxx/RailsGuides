# Retrieving a single object
# using a primary key
client = Client.find(10)

# take
client = Client.take

# first
client = Client.first

# last
client = Client.last

# find_by
Client.find_by first_name: 'Lifo'

# take!
client = Client.take!

# first!
client = Client.first!

# last!
client = Client.last!

# find_by!
Client.find_by! first_name: 'Lifo'


# Retrieving multiple objects
# using multiple primary keys
client = Client.find([1, 10])

# take
Client.take(2)

# first
Client.first(2)

# last
Client.last(2)


# Retrieving multiple objects in batches
# find_each
User.find_each(start: 2000, batch_size: 5000) do |user|
  NewsLetter.weekly_deliver(user)
end

# find_in_batches
Invoice.find_in_batches(include: :invoice_line) do |invoices|
  export.add_invoices(invoices)
end


# Conditions
# array conditions
Client.where("orders_count = ?", params[:orders])
Client.where("orders_count = ? AND locked = ?", params[:order], false)
Client.where("created_at >= :start_date AND created_at <= :end_date",
  {start_date: params[:start_date], end_date: params[:end_date]})

# hash conditions
Client.where(locked: true)
Client.where('Locked' => true)
Post.where(author: author)
Author.joins(:posts).where(posts: { author: author })
Client.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
Client.where(orders_count: [1,3,5])

# not conditions
Post.where.not(author: author)


# Ordering
Client.order(:created_at)
Client.roder("created_at")

Client.order(created_at: :desc)
Client.order("created_at ASC")
Client.order(orders_count: :asc, created_at: :desc)
Client.order(:order_count, create_at: :desc)
Client.order("order_count ASC, created_at DESC")
Client.order("order_count ASC", "created_at DESC")


# selecting specific fields
Client.select("viewable_by, locked")
Client.select(:name).distinct


# limit and offset
Client.limit(5)
Clent.limit(5).offset(30)


# group
Order.select("date(created_at) as ordered_date, sum(price) as total_price").group("date(created_at")


# having
Order.select("date(created_at) as ordered_date, sum(price) as total_price").
  group("date(created_at").having("sum(price) > ?", 100)


# overriding conditions
# unscope
Post.where('id >10').limit(20).order('id asc').except(:order)
Post.where(id: 10, trashed: false).unscope(where: :id)

# only
Post.where('id > 10').limit(20).order('id desc').only(:order, :where)

# reorder
Post.find(10).comments.reorder('name')

# reverse_order
Client.where("order_count > 10").order(:name).reverse_order

# rewhere
Post.where(trashed: true).rewhere(trashed: false)


# joining tables
Client.joins('LEFT OUTER JOIN addresses ON addresse.client_id = clients.id')
Category.joins(:posts)
Post.joins(:category, :comments)

# N + 1 queried problem
clients = Client.includes(:address).limit(10)


# find or build a new object
# find_or_create_by
Client.find_or_create_by(first_name: 'Andy')
Client.find_or_create_by!(first_name: 'Andy')

# find_or_initialize_by
nick = Client.find_or_initialize_by(first_name: 'Nick')


# calculations
Client.count
Client.average("orders_count")
Client.minimum("age")
Client.maximum("age")
Client.sum("orders_count")
