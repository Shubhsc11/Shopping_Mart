## Shopping Mart – Online Order Booking Platform

This project is a full-featured online shopping platform, similar to e-commerce and order booking systems found on popular sites. Users can browse products, add items to their cart, place orders, and track their order status.

### Features
- User authentication and management
- Product catalog with categories and subcategories
- Shopping cart functionality
- Order creation and management
- Order status tracking (created, placed, confirmed, shipped, delivered)
- Delivery details
- Admin dashboard for managing products, orders, users, and categories

### Tech Stack
- Ruby on Rails (API & web)
- PostgreSQL (database)
- HTML/CSS/JS (frontend)

### Project Structure
- Models: Product, Order, OrderItem, User, Category, Subcategory, DeliveryDetail
- Controllers: Orders, Products, Users, Categories, CartItems, etc.
- Admin: Separate admin controllers for management

### CI/CD & Code Quality
- GitHub Actions and CircleCI are set up for continuous integration.
- RSpec tests are written for backend functionality.
- RuboCop is used for code style and has been fixed.

### Deployment
See `render.yaml` for Render deployment configuration. Follow the steps in the Deployment section to deploy to Render.

### Getting Started
1. Clone the repository
2. Install dependencies: `bundle install`
3. Setup database: `rails db:create db:migrate db:seed`
4. Start server: `rails server`

### Render Deployment
See the Deployment instructions above and in `render.yaml`.
