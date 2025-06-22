<%-- 
    Document   : todo
    Created on : 23 Jun 2025, 12:49:42 am
    Author     : User
--%>

<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.TodoAPI" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>

<%
    // Create an instance of TodoAPI
    TodoAPI todoApi = new TodoAPI();
    String message = "";  // To store any success or error message for creating the task

    // Get the form data (title and completed status)
    String title = request.getParameter("title");
    String completedStr = request.getParameter("completed");
    boolean completed = completedStr != null && completedStr.equals("true");

    // If title is provided, create a new task
    if (title != null && !title.isEmpty()) {
        // Create the task using POST request
        JSONObject newTask = todoApi.createTask(title, completed);  // This returns a JSONObject

        // Fetch tasks from session or initialize an empty array
        JSONArray tasksArray = (JSONArray) session.getAttribute("tasks");
        if (tasksArray == null) {
            tasksArray = new JSONArray();  // Initialize if null
        }

        // Add the new task to the session
        tasksArray.put(newTask);  // Add new task to the array in session
        session.setAttribute("tasks", tasksArray);  // Update session with new task array

        message = "New Task Created: " + newTask.getString("title");  // Display the title of the created task
    }
%>

<html>
    <head>
        <title>Add To-Do Task</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Fonts & Icons -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&family=Poppins:wght@300;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <!-- Custom CSS -->
        <link rel="stylesheet" href="weather.css" />
        <link rel="stylesheet" href="layout.css" />
        <style>
            input, select, button, label {
                font-family: 'Poppins', sans-serif;
                font-size: 1em;
            }

            form label {
                display: block;
                margin-bottom: 0.5em;
                font-weight: 600;
            }

            input[type="text"], select {
                width: 100%;
                padding: 0.75em;
                margin-bottom: 1.5em;
                border-radius: 0.5em;
                border: 2px solid #a0c4ff;
            }

            button.back-btn {
                background-color: #3399ff;
                color: white;
                font-size: 1em;
                padding: 0.75em 1.5em;
                border: none;
                border-radius: 0.5em;
                font-weight: bold;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5em;
                transition: background-color 0.3s ease;
            }

            button.back-btn:hover {
                background-color: #1e7edb;
            }

            @media screen and (max-width: 600px) {
                .app-header-card h1 {
                    font-size: 1.5em;
                }

                .main-container, .app-header-card {
                    padding: 1em;
                }
            }
        </style>
    </head>
    <body>
        <div class="page-wrapper">
            <div class="app-header-card">
                <h1><i class="fas fa-newspaper"></i>DailyDose To-Do</h1>
                <p class="subtitle">Create and track your tasks easily</p>
            </div>

            <div class="main-container">
                <!-- Display the message after task creation -->
                <% if (!message.isEmpty()) {%>
                <p class="section"><%= message%></p>
                <% }%>

                <!-- Form to create a new task -->
                <form method="post" action="todo.jsp">
                    <div class="section">
                        <label for="title"><i class="fas fa-pencil-alt"></i> Task Title</label>
                        <input type="text" name="title" id="title" required />
                    </div>

                    <div class="section">
                        <label for="completed"><i class="fas fa-check-circle"></i> Completed</label>
                        <select name="completed" id="completed">
                            <option value="true">Yes</option>
                            <option value="false">No</option>
                        </select>
                    </div>

                    <div class="section">
                        <button type="submit" class="back-btn">
                            <i class="fas fa-plus-circle"></i> Create Task
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script src="index.js"></script>
    </body>
</html>
