<%-- 
    Document   : news.jsp
    Created on : 3 Jun 2025, 3:11:40 am
    Author     : ravib
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.NewsBean, java.util.List" %>
<%
    String keyword = request.getParameter("keyword");
    String language = request.getParameter("language");
    String country = request.getParameter("country");

    NewsBean newsBean = new NewsBean(keyword, language, country); // You'll need to overload NewsBean
    List<NewsBean.NewsArticle> articles = newsBean.getArticles();
%>
<!DOCTYPE html>
<html>
    <head>
        <title>News Search</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 2em;
                align-content: center;
                text-align: center;
            }

            h1 {
                color: cornflowerblue;
            }

            .input_txt {
                margin: 0.5em 0;
                height: 2.2em;
                width: 20em;
                border: groove;
                border-color: rgb(119, 158, 230);
                border-radius: 0.4em;
            }

            .input_Search {
                margin: 0.5em 0;
                color: white;
                font-weight: 600;
                width: 20em;
                border: groove;
                border-color: cornflowerblue;
                background-color: cornflowerblue;
                border-radius: 0.4em;
                cursor: pointer;
            }

            .input_txt:focus {
                border-color: rgb(40, 108, 233);
                box-shadow: 0 0 8px cornflowerblue;
            }

            .input_Search:hover {
                border-color: rgb(40, 108, 233);
                background-color: rgb(40, 108, 233);
                color: aliceblue;
            }

            .info_box {
                margin: 1em auto;
                border: solid 3px cornflowerblue;
                border-radius: 2em;
                padding: 1em;
                width: 22em;
            }

            .info_box p {
                margin: 0.5em 1em;
            }

            .headline {
                font-weight: bold;
            }

            .back_btn {
                margin-top: 1em;
                padding: 0.8em 1em;
                border-radius: 0.4em;
                background-color: lightgray;
                border: none;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <h1>News Search</h1>
        <form method="get" action="news.jsp">
            <div>
                <label>Keyword:</label><br/>
                <input type="text" name="keyword" class="input_txt" placeholder="Enter keyword" />
            </div>
            <div>
                <label>Language:</label><br/>
                <select name="language" class="input_txt">
                    <option value="en">English</option>
                    <option value="ms">Malay</option>
                </select>
            </div>
            <div>
                <label>Country:</label><br/>
                <select name="country" class="input_txt">
                    <option value="my">Malaysia</option>
                    <option value="us">United States</option>
                    <option value="th">Thailand</option>
                    <option value="sg">Singapore</option>
                </select>
            </div>
            <input type="submit" value="Search" class="input_Search" />
        </form>

        <div class="info_box">
            <% int count = 1;
           for (NewsBean.NewsArticle article : articles) { %>
            <p><span class="headline"><%= count++ %>. <a href="<%= article.getUrl() %>" target="_blank"><%= article.getTitle() %></a></span><br/>
                <%= article.getSource() %> - <%= article.getPublishedDate() %></p>
                <% } %>
        </div>

        <form action="index.jsp">
            <input type="submit" value="Back to Home" class="back_btn" />
        </form>
    </body>
</html>