<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.NewsBean, java.util.List, java.util.Map" %>
<%
    NewsBean newsBean = new NewsBean(); // default fetch
    List<NewsBean.NewsArticle> articles = newsBean.getArticles();
    Map<String, List<NewsBean.NewsArticle>> grouped = newsBean.getGroupedBySource();
    List<String> topKeywords = newsBean.getTopKeywords(5);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="news.css" />
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&family=Poppins:wght@300;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <title>DailyDose - News</title>
    </head>
    <body>
        <div class="main-container">
            <header class="app-header">
                <h1><i class="fas fa-newspaper"></i> DailyDose News</h1>
                <p class="subtitle">Curated headlines. Clean design. Powered by you.</p>
            </header>


            <!-- Trending Keywords -->
            <div class="section">
                <h2><i class="fas fa-fire"></i> Trending Keywords</h2>
                <div class="keywords">
                    <% for (String word : topKeywords) {%>
                    <span class="keyword-chip">#<%= word%></span>
                    <% } %>
                </div>

                <!-- Trigger Button -->
                <div class="floating-search-trigger" onclick="toggleSearchModal()">
                    <i class="fas fa-search"></i> Search Articles
                </div>

                <!-- Modal -->
                <div class="floating-search-modal" id="searchModal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <input type="text" id="searchInput" placeholder="Type to search..." oninput="filterArticles()" />
                            <button class="close-btn" onclick="toggleSearchModal()">×</button>
                        </div>
                        <div id="searchResults"></div>
                    </div>
                </div>



            </div>

            <!-- Top Headlines -->
            <div class="section">
                <h2><i class="fas fa-globe"></i> Top Headlines</h2>
                <div class="headlines">
                    <% for (NewsBean.NewsArticle article : articles) {%>
                    <div class="headline-card">
                        <a href="<%= article.getUrl()%>" target="_blank"><%= article.getTitle()%></a><br/>
                        <div class="meta"><%= article.getSource()%> | <%= article.getPublishedDate()%></div>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- Grouped News -->
            <div class="card news-by-source">
                <h2><i class="fa-solid fa-layer-group"></i> More News by Source</h2>

                <div class="source-tabs" id="tab-container">
                    <% int i = 0;
                        for (String source : grouped.keySet()) {%>
                    <div class="source-tab <%= (i == 0 ? "active" : "")%>" 
                         onclick="showSource('<%= source.replaceAll(" ", "")%>')" 
                         data-source="<%= source.replaceAll(" ", "")%>">
                        <%= source%>
                    </div>
                    <% i++;
                        } %>
                </div>

                <% i = 0;
                    for (Map.Entry<String, List<NewsBean.NewsArticle>> entry : grouped.entrySet()) {
                        String sourceId = entry.getKey().replaceAll(" ", "");
                %>
                <div class="source-content <%= (i == 0 ? "active" : "")%>" id="<%= sourceId%>">
                    <h3><%= entry.getKey()%></h3>
                    <div class="source-articles">
                        <ul>
                            <% for (NewsBean.NewsArticle article : entry.getValue()) {%>
                            <li>
                                <a href="<%= article.getUrl()%>" target="_blank"><%= article.getTitle()%></a>
                                <span class="meta">(<%= article.getPublishedDate()%>)</span>
                            </li>
                            <% } %>
                        </ul>
                    </div>
                </div>
                <% i++;
                    }%>
            </div>

            <!-- Back Button -->
            <form action="index.jsp">
                <input type="submit" value="⏪ Back to Home" class="back-btn" />
            </form>
        </div>
        <!-- JS for tab switching -->
        <script>
            let currentTab = 0;
            const tabs = document.querySelectorAll(".source-tab");
            const contents = document.querySelectorAll(".source-content");

            function showSource(sourceId) {
                contents.forEach(content => {
                    content.classList.remove("active");
                });

                tabs.forEach(tab => {
                    tab.classList.remove("active");
                });

                document.getElementById(sourceId).classList.add("active");
                const targetTab = Array.from(tabs).find(tab => tab.dataset.source === sourceId);
                if (targetTab)
                    targetTab.classList.add("active");
            }

            setInterval(() => {
                currentTab = (currentTab + 1) % tabs.length;
                const sourceId = tabs[currentTab].dataset.source;
                showSource(sourceId);
            }, 2000);

            function toggleSearchModal() {
                const modal = document.getElementById('searchModal');
                modal.classList.toggle('active');
            }

            function filterArticles() {
                const query = document.getElementById('searchInput').value.toLowerCase();
                const allArticles = document.querySelectorAll('.source-articles a');
                const resultsContainer = document.getElementById('searchResults');

                resultsContainer.innerHTML = "";

                if (query.trim() === "")
                    return;

                allArticles.forEach(article => {
                    if (article.textContent.toLowerCase().includes(query)) {
                        const clone = article.cloneNode(true);
                        const wrapper = document.createElement("p");
                        wrapper.appendChild(clone);
                        resultsContainer.appendChild(wrapper);
                    }
                });

                if (resultsContainer.innerHTML === "") {
                    resultsContainer.innerHTML = "<p>No results found.</p>";
                }
            }
        </script>

    </body>
</html>
