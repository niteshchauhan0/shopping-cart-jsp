<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Dynamic Theme Style -->
    <style id="theme-style"></style>

    <!-- Base Styling -->
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .btn {
            border-radius: 8px;
        }
        .list-group-item {
            border-radius: 8px;
        }
    </style>

    <!-- Theme Toggle Script -->
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const theme = localStorage.getItem('theme') || 'light';
            applyTheme(theme);
        });

        function toggleTheme() {
            const current = localStorage.getItem('theme') === 'dark' ? 'light' : 'dark';
            localStorage.setItem('theme', current);
            applyTheme(current);
        }

        function applyTheme(theme) {
            const styleTag = document.getElementById('theme-style');
            if (theme === 'dark') {
                styleTag.innerHTML = `
                    body { background-color: #121212; color: #f1f1f1; }
                    .card, .form-control, .list-group-item { background-color: #1e1e1e !important; color: #f1f1f1; }
                    .btn-outline-dark { border-color: #aaa; color: #ccc; }
                    .btn-outline-dark:hover { background-color: #333; }
                `;
            } else {
                styleTag.innerHTML = ``;
            }
        }
    </script>
</head>
<body>
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-success">🧾 Checkout</h2>
            <button onclick="toggleTheme()" class="btn btn-outline-dark btn-sm">🌙 Toggle Theme</button>
        </div>

        <form action="ConfirmOrderServlet" method="post" class="card p-4">
            <div class="mb-3">
                <label for="name" class="form-label">👤 Full Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">📧 Email Address</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">📦 Shipping Address</label>
                <textarea name="address" rows="3" class="form-control" required></textarea>
            </div>

            <h5 class="text-muted">🛒 Order Summary:</h5>
            <ul class="list-group mb-3">
                <%
                    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
                    double total = 0;
                    if (cart != null) {
                        for (Map<String, Object> item : cart) {
                            String name = (String) item.get("name");
                            double price = (double) item.get("price");
                            int quantity = (int) item.get("quantity");
                            double subtotal = price * quantity;
                            total += subtotal;
                %>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <%= name %> × <%= quantity %>
                    <span>&#8377;<%= subtotal %></span>
                </li>
                <%  
                        }
                    }
                %>
                <li class="list-group-item fw-bold d-flex justify-content-between">
                    Total
                    <span>&#8377;<%= total %></span>
                </li>
            </ul>

            <button type="submit" class="btn btn-success w-100">✅ Confirm Order</button>
        </form>
    </div>

    <!-- Bootstrap Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
