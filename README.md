# 🛒 Shopping Cart Web Application

A dynamic and responsive shopping cart web application built using **JSP, Servlets, JDBC, and MySQL**, styled with **Bootstrap 5**, and featuring modern UI enhancements like **dark mode toggle**, **live quantity updates**, and a **mobile-friendly layout**.

## 📌 Features

- 🧾 View product list with selection and quantity
- 🛍️ Add items to cart
- ✏️ Update quantities directly in the cart
- 🧹 Empty the entire cart with a click
- 💳 Checkout with user details and order summary
- 🌙 Dark mode toggle (remembers user preference)
- 🧾 Export cart or order summary (PDF/Excel) *(planned)*
- 📱 Responsive design (mobile/tablet/desktop)

## 🛠️ Tech Stack

- **Frontend**: JSP, HTML, CSS, Bootstrap 5
- **Backend**: Java Servlets, JDBC
- **Database**: MySQL
- **Server**: Apache Tomcat
- **Tools**: Eclipse IDE, Git, GitHub

## 🔧 Setup Instructions

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/ShoppingAssessment.git
   cd ShoppingAssessment

2. **Import into Eclipse as an existing dynamic web project.

3. **Set up MySQL Database:-

CREATE DATABASE shopping_cart;
USE shopping_cart;

CREATE TABLE products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  price DOUBLE
);

INSERT INTO products (name, price) VALUES
('Laptop', 60000),
('Smartphone', 20000),
('Headphones', 1500),
('Backpack', 800),
('Keyboard', 1200);

4. **Update DB credentials in your DBUtil.java file.

5. **Deploy to Tomcat using Eclipse or manually.

6. **Access the app at:
http://localhost:8080/ShoppingAssessment/index.jsp


🎨 UI Highlights:-

🔲 Bootstrap-styled cards and tables

🌙 Dark mode using localStorage

✅ Toast messages and visual feedback (planned)

📱 Mobile-responsive layout

🙌 Author:- Nitesh Singh

--Feel free to fork or contribute to this project. Feedback and improvements are welcome!--
