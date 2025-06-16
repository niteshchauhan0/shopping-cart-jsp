<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.example.DBUtil" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Theme Style (Dynamic) -->
    <style id="theme-style"></style>

    <!-- Base Styles -->
    <style>
        body {
            background-color: #f1f3f5;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .btn {
            border-radius: 8px;
        }
        .table-hover tbody tr:hover {
            background-color: #e6f2ff;
        }
        @media (max-width: 576px) {
            .form-select {
                width: 100% !important;
            }
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
                    .card, .table, .table th, .table td { background-color: #1e1e1e !important; color: #f1f1f1; }
                    .table-primary { background-color: #2d2d2d !important; color: #fff; }
                    .btn-outline-secondary, .btn-outline-dark { border-color: #aaa; color: #ccc; }
                    .btn-outline-secondary:hover, .btn-outline-dark:hover { background-color: #333; }
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
            <h2 class="text-primary">🛍️ Products</h2>
            <button onclick="toggleTheme()" class="btn btn-outline-dark btn-sm">🌙 Toggle Theme</button>
        </div>

        <div class="card p-4">
            <form action="CartServlet" method="post">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-primary">
                            <tr>
                                <th>Select</th>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Connection conn = DBUtil.getConnection();
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM products");

                                    while (rs.next()) {
                            %>
                            <tr>
                                <td><input class="form-check-input" type="checkbox" name="productId" value="<%= rs.getInt("id") %>"></td>
                                <td><%= rs.getString("name") %></td>
                                <td>&#8377;<%= rs.getDouble("price") %></td>
                                <td>
                                    <select name="quantity" class="form-select w-auto">
                                        <% for (int i = 1; i <= 5; i++) { %>
                                            <option value="<%= i %>"><%= i %></option>
                                        <% } %>
                                    </select>
                                </td>
                            </tr>
                            <%
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='4' class='text-danger'>Error loading products.</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <div class="d-flex flex-wrap justify-content-center gap-3 mt-4">
                    <button type="submit" class="btn btn-success px-4">🛒 Add to Cart</button>
                    <a href="cart.jsp" class="btn btn-outline-secondary px-4">🧺 View Cart</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
