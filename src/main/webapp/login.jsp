<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort - Staff Login</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(135deg, #005c97 0%, #363795 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
        }
        .login-header {
            background-color: #004d80;
            color: white;
            padding: 30px 20px;
            text-align: center;
        }
        .login-body {
            padding: 40px 30px;
        }
        .btn-primary {
            background-color: #004d80;
            border: none;
        }
        .btn-primary:hover {
            background-color: #003355;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="login-header">
            <h2>Ocean View Resort</h2>
            <p class="mb-0">Staff Reservation System</p>
        </div>
        
        <div class="login-body">
            <% 
                String errorMsg = request.getParameter("error");
                if (errorMsg != null) { 
            %>
                <div class="alert alert-danger" role="alert">
                    <%= errorMsg %>
                </div>
            <% } %>

            <form action="LoginServlet" method="POST">
                
                <div class="mb-3">
                    <label for="username" class="form-label text-muted fw-bold">Username</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter staff username" required>
                </div>
                
                <div class="mb-4">
                    <label for="password" class="form-label text-muted fw-bold">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">Secure Login</button>
                </div>
                
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>