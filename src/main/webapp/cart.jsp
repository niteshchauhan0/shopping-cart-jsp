<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style id="theme-style"></style>
    <style>
        .btn {
            border-radius: 8px;
        }
        .table-hover tbody tr:hover {
            background-color: #e6f2ff;
        }

        @media (max-width: 576px) {
            h2 {
                font-size: 1.3rem;
            }
            .btn {
                font-size: 0.9rem;
                padding: 6px 10px;
            }
            .table th, .table td {
                font-size: 0.85rem;
            }
        }
    </style>
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
                    .table, .table th, .table td { background-color: #1e1e1e !important; color: #f1f1f1; }
                    .table-success { background-color: #2d2d2d !important; color: #fff; }
                    .alert, .btn, .card { background-color: #2c2c2c; color: #fff; }
                `;
            } else {
                styleTag.innerHTML = ``;
            }
        }
    </script>
</head>

<body class="bg-light text-dark">
<div class="container mt-4">
    <div class="row mb-4">
        <div class="col-12 d-flex justify-content-between align-items-center flex-wrap">
            <h2 class="text-success mb-2">🛒 Your Shopping Cart</h2>
            <button onclick="toggleTheme()" class="btn btn-outline-secondary btn-sm mb-2">🌙 Toggle Theme</button>
        </div>
    </div>

    <%
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
        <div class="alert alert-warning">Your cart is empty.</div>
    <%
        } else {
    %>
    <div class="table-responsive">
        <table class="table table-bordered table-hover shadow-sm">
            <thead class="table-success">
                <tr>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    double total = 0;
                    for (Map<String, Object> item : cart) {
                        int id = (int) item.get("id");
                        String name = (String) item.get("name");
                        double price = (double) item.get("price");
                        int quantity = item.get("quantity") != null ? (int) item.get("quantity") : 1;
                        double subtotal = price * quantity;
                        total += subtotal;
                %>
                <tr>
                    <td><%= name %></td>
                    <td>&#8377;<%= price %></td>
                    <td>
                        <form action="CartServlet" method="post" class="d-flex flex-wrap">
                            <input type="hidden" name="updateId" value="<%= id %>">
                            <input type="number" name="newQuantity" value="<%= quantity %>" min="1"
                                   class="form-control form-control-sm me-2 mb-2" style="width: 80px;" required>
                            <button type="submit" class="btn btn-sm btn-outline-primary mb-2">Update</button>
                        </form>
                    </td>
                    <td>&#8377;<%= subtotal %></td>
                    <td>
                        <form action="CartServlet" method="post" class="d-flex flex-wrap align-items-center">
                            <input type="hidden" name="removeId" value="<%= id %>">
                            <input type="number" name="removeQty" value="1" min="1" max="<%= quantity %>"
                                   class="form-control form-control-sm me-2 mb-2" style="width: 80px;" required>
                            <button type="submit" class="btn btn-sm btn-danger mb-2">Remove Qty</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                <tr class="fw-bold">
                    <td colspan="3">Total</td>
                    <td colspan="2">&#8377;<%= total %></td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Action Buttons -->
    <div class="d-flex flex-wrap gap-2 mt-3">
        <form action="CartServlet" method="post" onsubmit="return confirm('Are you sure you want to empty your cart?');">
            <input type="hidden" name="action" value="emptyCart">
            <button type="submit" class="btn btn-outline-danger">🗑️ Empty Cart</button>
        </form>

        <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#cartSummaryModal">
            🧾 View Cart Summary
        </button>

        <a href="checkout.jsp" class="btn btn-success">✅ Proceed to Checkout</a>
        <a href="index.jsp" class="btn btn-primary">⬅️ Back to Products</a>
    </div>
    <%
        }
    %>
</div>

<!-- Cart Summary Modal -->
<div class="modal fade" id="cartSummaryModal" tabindex="-1" aria-labelledby="cartSummaryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="cartSummaryModalLabel">🧾 Cart Summary</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <%
                    if (cart != null && !cart.isEmpty()) {
                %>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-info">
                            <tr>
                                <th>Product</th>
                                <th>Qty</th>
                                <th>Price</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                double summaryTotal = 0;
                                for (Map<String, Object> item : cart) {
                                    String name = (String) item.get("name");
                                    int qty = (int) item.get("quantity");
                                    double price = (double) item.get("price");
                                    double subtotal = qty * price;
                                    summaryTotal += subtotal;
                            %>
                            <tr>
                                <td><%= name %></td>
                                <td><%= qty %></td>
                                <td>&#8377;<%= price %></td>
                                <td>&#8377;<%= subtotal %></td>
                            </tr>
                            <% } %>
                            <tr class="fw-bold">
                                <td colspan="3">Total</td>
                                <td>&#8377;<%= summaryTotal %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <%
                    } else {
                %>
                <div class="alert alert-warning">Your cart is empty.</div>
                <%
                    }
                %>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <a href="checkout.jsp" class="btn btn-success">✅ Proceed to Checkout</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
