<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light text-dark">
    <div class="container mt-5 text-center">
        <h2 class="text-success"><%= request.getAttribute("message") %></h2>
        <p class="mt-3">We will deliver your order soon. You can continue shopping now.</p>
        <a href="index.jsp" class="btn btn-primary mt-3">🏠 Back to Home</a>
    </div>
</body>
</html>
